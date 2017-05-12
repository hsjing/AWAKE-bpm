`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TRIUMF
// Engineer: Shengli Liu
// 
// Create Date:    11:14:18 03/07/2016 
// Design Name: 
// Module Name:    Buf_SigProcs 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: top module of Circular buffer, BLR_Gain, Power calculation, etc, 
//              the purpose of this package is to make simulation seperatly from MB and ADC deserilize.
// The circular buff is 10.24 us deep @ 100MSPS ADC rate, i.e. 1024 smaples, this means the trigger latency could not 
// be greater than 6 us to have 424 samples for the event tail.
//  
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Revision 0.02 - Online calibration added, by SL, 2017/03/15
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Buf_SigProcs(
	input [63:0] data_in, // data from deserializer
	input gclk0, // ADC data clk, 100MHz
	input clk, // slow processing clk, 10 MHz from PLL
	input rst,

	input ex_trig,
	input veto,

	input MB_bus_Clk,
	input fifo_rd_ab,
	input fifo_rd_cd,

	output [FIFO_DEPTH-1:0] AB_fifo_word,
	output [FIFO_DEPTH-1:0] CD_fifo_word,

	output [4*ADC_BIT_WIDTH-1:0] fast_fifo_dout,

	input sFIFO_rd,
	output [5:0] slow_fifo_wd,
	output [SFIFO_WIDTH-1:0] slow_fifo_dout,

	input [DATA_WIDTH-1:0] BPM_Dia,
	// for testing position on labview
	output [DATA_WIDTH-1:0] X_reg,
	output [DATA_WIDTH-1:0] Y_reg,
	output [DATA_WIDTH-1:0] S_reg,

	output [SF_WIDTH-1:0] ChA_Power_reg,
	output [SF_WIDTH-1:0] ChB_Power_reg,
	output [SF_WIDTH-1:0] ChC_Power_reg,
	output [SF_WIDTH-1:0] ChD_Power_reg,

	input [DATA_WIDTH-1:0] Trig_TH_Reg,
	input [DATA_WIDTH-1:0] Trig_DT_Reg,
	input [DATA_WIDTH-1:0] Trig_DL_Reg,
	input [DATA_WIDTH-1:0] Evt_Len_Reg, // Event Length in samples reg
	input [DATA_WIDTH-1:0] Evt_Tail_Len_Reg, // Event tail length in samples reg
	input [DATA_WIDTH-1:0] BL_Len_Reg, // Event tail length in samples reg
	
	input [SF_WIDTH-1:0] ChA_Gain,
	input [SF_WIDTH-1:0] ChB_Gain,
	input [SF_WIDTH-1:0] ChC_Gain,
	input [SF_WIDTH-1:0] ChD_Gain,
	input [SF_WIDTH-1:0] ChA_Cal_Gain,
	input [SF_WIDTH-1:0] ChB_Cal_Gain,
	input [SF_WIDTH-1:0] ChC_Cal_Gain,
	input [SF_WIDTH-1:0] ChD_Cal_Gain,


	input [SF_WIDTH-1:0] K_cal,
	input [4:0] DIGI_att,
	input [4:0] VGA_gain,

	output [DATA_WIDTH-1:0]status_net,
	input  [DATA_WIDTH-1:0]control_reg,

	output trig_out, // for driving LED and SMA trigger output
	output cal_on, // to turn on/off caliberation siganl
	output busy // to prevent the Fast fifo to be readout by MB
	
    );

	parameter  	ADC_BIT_WIDTH = 16;
	parameter  	DATA_WIDTH = 16;
	parameter  	FIFO_DEPTH = 11;
	parameter   SFIFO_WIDTH = 32;
	parameter  	SF_WIDTH = 32;
	parameter	AUTO_MODE = 1;	// Ranging mode select (1 = auto, 0 = manual)
 
/////////////////////////////////////////////////////////////
//====================== chipScope components================
////////////////////////////////////////////////////////////
	/*
	 * wire [35:0] ila_CONTROL0,ila_CONTROL1;

	 * icon icon_test (
	 *     .CONTROL0(ila_CONTROL0), // INOUT BUS [35:0]
	 * 	 .CONTROL1(ila_CONTROL1)
	 * );
	 *  
	 */
	wire trig;
	assign trig_out = trig;

	wire cal_trig; // one clk wide (100 ns), to start calibertaion event 
	wire cal_flag; // mark the cal event

	wire rd_C_buffer;
	wire event_rdy;

	wire RUN = control_reg[0];
	wire [1:0] TRIG_MODE = control_reg[2:1];
	wire en_temp = control_reg[5];

	wire RST_EVENT_NO = control_reg[12];
	wire Cal_ST_Mode = control_reg[13];
	wire Cal_OL_Mode = control_reg[14];

	wire [4*ADC_BIT_WIDTH-1:0] dout_all;

	wire Overflow_ChA;
	wire Overflow_ChB;
	wire Overflow_ChC;
	wire Overflow_ChD;


	x4_Channel_buffer Circular_Buffer (
		//.ila_control(ila_CONTROL0),
		.DIN(data_in), // ADC raw data from deserializer
		.EVENT_LEN(Evt_Len_Reg),
		.TAIL_LEN(Evt_Tail_Len_Reg),
		.RST(rst),
		.TRIG(trig),
		.WRCLK(gclk0),
		.RDCLK(clk),
		.RD(rd_C_buffer),

		.EVENT_RDY(event_rdy), // output,event ready
		.DOUT(dout_all)

	);


	trigger Trigger(
		.RUN(RUN),
		.VETO(veto),
		.TRIG_MODE(TRIG_MODE),
		.DATAIN(data_in), // ADC raw data from deserializer
		.CLK(gclk0),
		.RESET(rst),
		.EXT_TRIG(ex_trig | cal_trig),
		.THRESHOLD(Trig_TH_Reg),
		.DEAD_TIME(Trig_DT_Reg),
		.TRIG_DELAY(Trig_DL_Reg),
		.TRIG(trig)
	);


	wire data_BL_valid;
	wire BLG_data_valid;
	wire BL_updated;
	wire BLR_busy;
	wire clr_fast_fifo;
	assign busy = BLR_busy;

	wire [4*ADC_BIT_WIDTH-1:0] BLR_dout_all;
	wire [4*ADC_BIT_WIDTH-1:0] BL;

	base_line BL_cal(
		.in_valid(data_BL_valid),
		.din(dout_all),
		.clk(clk),
		.rst(rst),
		.out_valid(BL_updated),
		.BL_data(BL)
	);


	wire skip_BLR;
	wire wr_fast_fifo;

	BLR_GAIN BLR_ADJ(
		.RUN(RUN),
		.rst(rst),
		.clk(clk),

		.BL(BL), // input: calculated based line
		.BL_update(BL_updated), //

//for quick compiling only
//.BL(64'b0),
//.BL_update(1'b1),
		.cal_flag(cal_flag), // input from cal_schedule, indicates the cal event
		.skip_BLR(skip_BLR),
		.din(dout_all), // input from Circular buffer
		.BL_Len_Reg(BL_Len_Reg),

		.event_rdy(event_rdy), // input from Circular buffer
		.rd(rd_C_buffer), // output, read Circular channel buffer 
		.wr(wr_fast_fifo), // output, write Fast fifo
	
	.data_BL_valid(data_BL_valid), // mark the data for Base line calculation
		.data_valid(BLG_data_valid), // mark the data after BLR and Gain adj. is present on bus
		.busy(BLR_busy), // to prevent the Fast fifo to be readout by MB
		.clr_fast_fifo(clr_fast_fifo), // clr the fast fifo so it keeps fresh if not been read out
		.dout(BLR_dout_all)
	);

//store the max ADC value and check over-flow
	wire [DATA_WIDTH-1:0] ChA_Max_Reg;
	wire [DATA_WIDTH-1:0] ChB_Max_Reg;
	wire [DATA_WIDTH-1:0] ChC_Max_Reg;
	wire [DATA_WIDTH-1:0] ChD_Max_Reg;

	Max Max_inst(
		.Input_valid(BLG_data_valid),
		.DATAIN(BLR_dout_all),
		.clk(clk),
		.rst(rst),

		.Max_A(ChA_Max_Reg),
		.Max_B(ChB_Max_Reg),
		.Max_C(ChC_Max_Reg),
		.Max_D(ChD_Max_Reg),

		.over_flow_A(Overflow_ChA),
		.over_flow_B(Overflow_ChB),
		.over_flow_C(Overflow_ChC),
		.over_flow_D(Overflow_ChD)
	);
	

//Fast FIFO to transfer ADC rate data from FPGA to MB
	wire fast_fifo_full,fast_fifo_empty;

	wire [4*ADC_BIT_WIDTH-1:0] fast_fifo_din = control_reg[8]?  BLR_dout_all
	: dout_all;
	assign skip_BLR = control_reg[9];
	assign status_net[DATA_WIDTH-1:0] = {Overflow_ChA,Overflow_ChB,Overflow_ChC,Overflow_ChD,10'b0,fast_fifo_full,RUN};

	wire fast_FIFO_rst = rst | clr_fast_fifo;

	FIFO_data Fast_FIFO_ChAB (
		.rst(fast_FIFO_rst), //
		.wr_clk(clk), //
		.rd_clk(MB_bus_Clk), //
		.din(fast_fifo_din[31:0]), // input [31 : 0] din
		.wr_en(wr_fast_fifo), //
		.rd_en(fifo_rd_ab),
		.dout(fast_fifo_dout[31:0]), // output [31 : 0] dout
		.full(fast_fifo_full), //
		.empty(fast_fifo_empty),
		.wr_data_count(AB_fifo_word) //
	);

	FIFO_data Fast_FIFO_ChCD (
		.rst(fast_FIFO_rst), //
		.wr_clk(clk), //
		.rd_clk(MB_bus_Clk), //
		.din(fast_fifo_din[63:32]), // input [31 : 0] din
		.wr_en(wr_fast_fifo), //
		.rd_en(fifo_rd_cd),
		.dout(fast_fifo_dout[63:32]), // output [31 : 0] dout
		.full(), //
		.empty(),
		.wr_data_count(CD_fifo_word) //
	);

	wire [SF_WIDTH-1:0] ChA_Power;
	wire [SF_WIDTH-1:0] ChB_Power;
	wire [SF_WIDTH-1:0] ChC_Power;
	wire [SF_WIDTH-1:0] ChD_Power;

	reg [SF_WIDTH-1:0] ChA_Power_reg;
	reg [SF_WIDTH-1:0] ChB_Power_reg;
	reg [SF_WIDTH-1:0] ChC_Power_reg;
	reg [SF_WIDTH-1:0] ChD_Power_reg;



	wire Power_rdy;
	wire [15:0] Total_N;

	Power_rms ChA_Power_inst(
		.Data_In(BLR_dout_all[15:0]),
		.Data_In_Valid(BLG_data_valid),
		.clk(clk),
		.rst(rst),

		.RMS(ChA_Power),
		.Total_N(Total_N),
		.RDY(Power_rdy)
	);

	Power_rms ChB_Power_inst(
		.Data_In(BLR_dout_all[31:16]),
		.Data_In_Valid(BLG_data_valid),
		.clk(clk),
		.rst(rst),

		.RMS(ChB_Power),
		.RDY()
	);

	Power_rms ChC_Power_inst(
		.Data_In(BLR_dout_all[47:32]),
		.Data_In_Valid(BLG_data_valid),
		.clk(clk),
		.rst(rst),

		.RMS(ChC_Power),
		.RDY()
	);

	Power_rms ChD_Power_inst(
		.Data_In(BLR_dout_all[63:48]),
		.Data_In_Valid(BLG_data_valid),
		.clk(clk),
		.rst(rst),

		.RMS(ChD_Power),
		.RDY()
	);	

///////////// apply Gain adjustment ////////////////////////////
	wire [SF_WIDTH-1:0] ChA_Drift_Gain;
	wire [SF_WIDTH-1:0] ChB_Drift_Gain;
	wire [SF_WIDTH-1:0] ChC_Drift_Gain;
	wire [SF_WIDTH-1:0] ChD_Drift_Gain;

	wire [SF_WIDTH-1:0] ChA_Power_VGA;
	wire [SF_WIDTH-1:0] ChB_Power_VGA;
	wire [SF_WIDTH-1:0] ChC_Power_VGA;
	wire [SF_WIDTH-1:0] ChD_Power_VGA;
	wire VGA_rdy;

	wire [SF_WIDTH-1:0] ChA_Power_Adj;
	wire [SF_WIDTH-1:0] ChB_Power_Adj;
	wire [SF_WIDTH-1:0] ChC_Power_Adj;
	wire [SF_WIDTH-1:0] ChD_Power_Adj;
	wire Adj_rdy; // one clk wide

//VGA module adjusts both Digi_attenuator and VGA gain setting
	VGA VGA_inst(
		.DIGI_att(DIGI_att),
		.VGA_gain(VGA_gain),

		.ChA_Power(ChA_Power),
		.ChB_Power(ChB_Power),
		.ChC_Power(ChC_Power),
		.ChD_Power(ChD_Power),

		.clk(clk),
		.rst(rst),
		.datain_valid(Power_rdy),

		.ChA_Power_Out(ChA_Power_VGA),
		.ChB_Power_Out(ChB_Power_VGA),
		.ChC_Power_Out(ChC_Power_VGA),
		.ChD_Power_Out(ChD_Power_VGA),
		.Adj_rdy(VGA_rdy)

	);

	Gain_Adjust Gain_Adjust_inst(
		.Cal_ST(Cal_ST_Mode),
		.Cal_OL(Cal_OL_Mode),
		.Cal_FLAG(cal_flag),

		.ChA_Gain(ChA_Gain),
		.ChB_Gain(ChB_Gain),
		.ChC_Gain(ChC_Gain),
		.ChD_Gain(ChD_Gain),

		.ChA_Cal_Gain(ChA_Cal_Gain),
		.ChB_Cal_Gain(ChB_Cal_Gain),
		.ChC_Cal_Gain(ChC_Cal_Gain),
		.ChD_Cal_Gain(ChD_Cal_Gain),

		.ChA_Drift_Gain(ChA_Drift_Gain),
		.ChB_Drift_Gain(ChB_Drift_Gain),
		.ChC_Drift_Gain(ChC_Drift_Gain),
		.ChD_Drift_Gain(ChD_Drift_Gain),


		.ChA_Power(ChA_Power_VGA),
		.ChB_Power(ChB_Power_VGA),
		.ChC_Power(ChC_Power_VGA),
		.ChD_Power(ChD_Power_VGA),
		.clk(clk),
		.rst(rst),
		.datain_valid(VGA_rdy),

		.ChA_Power_Adj(ChA_Power_Adj),
		.ChB_Power_Adj(ChB_Power_Adj),
		.ChC_Power_Adj(ChC_Power_Adj),
		.ChD_Power_Adj(ChD_Power_Adj),
		.Adj_rdy(Adj_rdy)

	);

	reg [SF_WIDTH-1:0] ChA_Power_cal;
	reg [SF_WIDTH-1:0] ChB_Power_cal;
	reg [SF_WIDTH-1:0] ChC_Power_cal;
	reg [SF_WIDTH-1:0] ChD_Power_cal;


	always @ (posedge clk)
	begin
		if (Adj_rdy && !cal_flag ) // real events
			begin
				ChA_Power_reg <= ChA_Power_Adj;
				ChB_Power_reg <= ChB_Power_Adj;
				ChC_Power_reg <= ChC_Power_Adj;
				ChD_Power_reg <= ChD_Power_Adj;
			end
		else if (Adj_rdy && cal_flag ) // cal events
			begin
				ChA_Power_cal <= ChA_Power_Adj;
				ChB_Power_cal <= ChB_Power_Adj;
				ChC_Power_cal <= ChC_Power_Adj;
				ChD_Power_cal <= ChD_Power_Adj;
			end
	end

//// Drift Compensation ///////////////////////
	wire Corr_rdy;

	Drift Drift_inst(
		// .ila_CONTROL0(ila_CONTROL0),
		// .ila_CONTROL1(ila_CONTROL1),
		.K_cal(K_cal),

		.A_Cal(ChA_Power_cal),
		.B_Cal(ChB_Power_cal),
		.C_Cal(ChC_Power_cal),
		.D_Cal(ChD_Power_cal),

		.clk(clk),
		.rst(rst),
		.data_valid(Adj_rdy && cal_flag),

		.ChA_Gain_Corr(ChA_Drift_Gain),
		.ChB_Gain_Corr(ChB_Drift_Gain),
		.ChC_Gain_Corr(ChC_Drift_Gain),
		.ChD_Gain_Corr(ChD_Drift_Gain),

		.Corr_rdy(Corr_rdy)
	);


///// Position/////////////////
	wire position_rdy;
	wire [SF_WIDTH-1:0] X,Y,S;
	reg [DATA_WIDTH-1:0] X_reg,Y_reg,S_reg;
	reg [DATA_WIDTH-1:0] X_cal_reg,Y_cal_reg,S_cal_reg;

	position position_inst(
		.clk(clk),
		.rst(rst),
		.data_valid(Adj_rdy),
		.A_IN(ChA_Power_Adj), // 32 bit sf
		.B_IN(ChB_Power_Adj),
		.C_IN(ChC_Power_Adj),
		.D_IN(ChD_Power_Adj),
		.Diameter(BPM_Dia),
		.X(X),
		.Y(Y),
		.S(S),
		.rdy(position_rdy) // one clk wide
	);
	
	//////////////////////////////////////////////////
	// auto_range.v
	//////////////////////////////////////////////////
	
	wire auto
	
	auto_range auto_range_inst(
		.clk(clk),
		.auto_enable(AUTO_MODE),
		.ready(position_rdy),
		.vga_in(VGA_gain),
		.signal_max_a(ChA_Max_Reg),
		.signal_max_b(ChB_Max_Reg),
		.signal_max_c(ChC_Max_Reg),
		.signal_max_d(ChD_Max_Reg),

		.vga_out(VGA_gain)
	);
	

	always @ (posedge clk)
	begin
		if (position_rdy && !cal_flag) // real events
			begin
				X_reg <= X[DATA_WIDTH-1:0]; // this cut off is valid, since the 32bit fix point format is 2's completment
				Y_reg <= Y[DATA_WIDTH-1:0];
				S_reg <= S[DATA_WIDTH-1:0];
			end
		else if (position_rdy && cal_flag) // cal events	
			begin
				X_cal_reg <= X[DATA_WIDTH-1:0];
				Y_cal_reg <= Y[DATA_WIDTH-1:0];
				S_cal_reg <= S[DATA_WIDTH-1:0];
			end
	end
 

///================ Slow FIFO ===================
	reg sFIFO_wr;
	wire esFIFO_half_full;
	reg [SFIFO_WIDTH-1:0] sfifo_data_in;
	ccd_fifo Slow_FIFO (
		.rst(rst),
		.din(sfifo_data_in),
		.wr_clk(clk),
		.rd_clk(MB_bus_Clk),
		.wr_en(sFIFO_wr),
		.rd_en(sFIFO_rd),
		.dout(slow_fifo_dout),
		.rd_data_count(slow_fifo_wd), // output [5 : 0] wr_data_count
		.prog_full(sFIFO_half_full)

	);
	 

//============Packing=================================
	parameter PID = 32'h4142504d; // "ABPM"
	parameter PACKET_LEN = 16'd16;

	reg [15:0] EVT_CNT;

	always @(posedge clk)
	if(RST_EVENT_NO) EVT_CNT <= 0;
	else	if(Adj_rdy && !cal_flag) EVT_CNT <= EVT_CNT + 1;


	reg [7:0] p_state;

//data packet size is 16 words (32bit)
	always @(posedge clk)
	begin
		if(rst)
			begin
				p_state <= 0;
				sFIFO_wr<= 0;
			end

		else
			begin
				case(p_state)
					0:if(position_rdy && !cal_flag && !sFIFO_half_full) begin  sFIFO_wr<= 1; sfifo_data_in <= PID; p_state <= 1; end

					1: begin sfifo_data_in <= {status_net,EVT_CNT}; p_state <= 2; end

					2: begin sfifo_data_in <= {X_reg,Y_reg}; p_state <= 3; end
					3: begin sfifo_data_in <= {S_reg,16'b0}; p_state <= 4; end
					4: begin sfifo_data_in <= ChA_Power_reg; p_state <= 5; end
					5: begin sfifo_data_in <= ChB_Power_reg; p_state <= 6; end
					6: begin sfifo_data_in <= ChC_Power_reg; p_state <= 7; end
					7: begin sfifo_data_in <= ChD_Power_reg; p_state <= 8; end


					// 9: begin sfifo_data_in <= {chA_temp_reg,chB_temp_reg}; p_state <= 10; end
					// 10: begin sfifo_data_in <= {chC_temp_reg,chD_temp_reg}; p_state <= 11; end
					// 11: begin sfifo_data_in <= BL[31:0]; p_state <= 12; end  //baseline
					// 12: begin sfifo_data_in <= BL[63:32]; p_state <= 13; end
					// 13: begin sfifo_data_in <= {X_cal_reg,Y_cal_reg}; p_state <= 14; end  
					8:  begin sfifo_data_in <= {ChA_Max_Reg,ChB_Max_Reg}; p_state <= 9; end
					9:  begin sfifo_data_in <= {ChC_Max_Reg,ChD_Max_Reg}; p_state <= 10; end

					10: begin sfifo_data_in <= {X_cal_reg,Y_cal_reg}; p_state <= 11; end
					11: begin sfifo_data_in <= 0; p_state <= 12; end

					12: begin sfifo_data_in <= ChA_Power_cal; p_state <= 13; end
					13: begin sfifo_data_in <= ChB_Power_cal; p_state <= 14; end
					14: begin sfifo_data_in <= ChA_Drift_Gain; p_state <= 15; end
					15: begin sfifo_data_in <= ChB_Drift_Gain; p_state <= 16; end

					16: begin sFIFO_wr<= 0; p_state <= 0; end

					default:
					p_state <= 0;
				endcase
			end

	end

//// Caliberation schedule ////////////////////////////////////
	cal_schedule cal_schedule_inst(
		.TRIG_MODE(TRIG_MODE),
		.Cal_ST(Cal_ST_Mode),
		.Cal_OL(Cal_OL_Mode),
		.clk(clk), // 10 MHz clock
		.rst(rst),

		.packing_done(position_rdy), // this is one clk wide
	
	.cal_trig(cal_trig), // one clk wide, 100 ns, this is ok!
		.cal_on(cal_on), // turn on/off cal signal
		.cal_flag(cal_flag) // to mark the current event, asserted until poisiton_rdy

    );

//////////////////////////////////////////////
//				ChipScope					//
//////////////////////////////////////////////
	/*
	 * wire [7:0] ila_trig = {6'b0,trig,event_rdy};
	 * wire [63:0] ila_data;

	 * assign ila_data = dout_all;
	 * ila_trig8 ila_trig8_inst (
	 *     .CONTROL(ila_CONTROL0), // INOUT BUS [35:0]
	 *     .CLK(clk), // IN
	 *     .TRIG0(ila_trig), // IN BUS [7:0]
	 * 	 .DATA(ila_data) // IN BUS [63:0]
	 * );



	 * ila_trig8 ila_trig8_fast_inst (
	 *     .CONTROL(ila_CONTROL1), // INOUT BUS [35:0]
	 *     .CLK(gclk0), // IN
	 * 	 //.CLK(clk),
	 *     .TRIG0({7'b0,trig}), // IN BUS [7:0]
	 * 	 .DATA(data_in) // IN BUS [63:0]
	 * );
	 */
endmodule
