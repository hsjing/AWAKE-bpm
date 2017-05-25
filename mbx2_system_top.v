`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Design Name:    TRIUMF AWAKE BPM Electronics Module FPGA  
// Module Name:    mbx2_system_top.v 
// Target Devices: xc6slx150t-3fgg676
// Tool versions:  ISE 13.3 (32 bit) under Windows 8.1pro/64bit.

// Description:    Top module for the whole project. 

// Revision: 2017_05_02, SL
// 
//////////////////////////////////////////////////////////
//!!!change the version# when compile new version!!!    //         
//////////////////////////////////////////////////////////
//status: 
//Aug16,2016: SPI not tested, on-line cal not finished. otherwise it is working.
//Apr.18,2017: added digi-Attenuator,on-line cal.
//May 2,2017: to add Digi_Att LUT, ABSKEW, CDSKEW, Auto-range

module mbx2_system_top (
//MB interface to outside of FPGA
  inout  zio,
  inout  rzq,
  output mcbx_dram_we_n,
  inout  mcbx_dram_udqs_n,
  inout  mcbx_dram_udqs,
  output mcbx_dram_udm,
  output mcbx_dram_ras_n,
  output mcbx_dram_odt,
  output mcbx_dram_ldm,
  inout  mcbx_dram_dqs_n,
  inout  mcbx_dram_dqs,
  inout  [15:0] mcbx_dram_dq,
  output mcbx_dram_ddr3_rst,
  output mcbx_dram_clk_n,
  output mcbx_dram_clk,
  output mcbx_dram_cke,
  output mcbx_dram_cas_n,
  output [2:0] mcbx_dram_ba,
  output [12:0] mcbx_dram_addr,
  output RS232_sout,
  input  RS232_sin,
  output RS232_USB_sout,
  input  RS232_USB_sin,
  input  RESET,
  input  [2:0] Push_Buttons_3Bits_TRI_I,
  output Linear_Flash_we_n,
  output Linear_Flash_reset,
  output Linear_Flash_oe_n,
  inout  [0:15] Linear_Flash_data,
  output Linear_Flash_ce_n,
  output [0:23] Linear_Flash_address,
  output [7:0] LEDs_8Bits_TRI_O,
  output Ethernet_Lite_TX_EN,
  input  Ethernet_Lite_TX_CLK,
  output [3:0] Ethernet_Lite_TXD,
  input  Ethernet_Lite_RX_ER,
  input  Ethernet_Lite_RX_DV,
  input  Ethernet_Lite_RX_CLK,
  input  [3:0] Ethernet_Lite_RXD,
  output Ethernet_Lite_PHY_RST_N,
  inout  Ethernet_Lite_MDIO,
  output Ethernet_Lite_MDC,
  input  Ethernet_Lite_CRS,
  input  Ethernet_Lite_COL,
  input  [7:0] DIP_Switches_8Bits_TRI_I,
  input  CLK,

// ============== ADC interface =============	
	 input FCLK_P,							//FCLKP
	 input FCLK_N,							//FCLKN
	 input DCLK_P,				         //DCLKP
	 input DCLK_N,				         //DCLKN	 
	 input DA0_P,						   //DA0P
	 input DA0_N,						   //DA0N	
	 input DA1_P,						   //DA1P
	 input DA1_N,				 			//DA1N
	 input DB0_P,						   //DB0P
	 input DB0_N,						   //DB0N
	 input DB1_P,						   //DB1P
	 input DB1_N,						   //DB1N
	 input DC0_P,						   //DC0P
	 input DC0_N,						   //DC0N
	 input DC1_P,						   //DC1P
	 input DC1_N,						   //DC1N
	 input DD0_P,						   //DD0P
	 input DD0_N,						   //DD0N
	 input DD1_P,						   //DD1P
	 input DD1_N,					   	 //DD1N
	 
	 inout SDATA,              // ADC SPI SDIO line      
	 output SCLK,  				// ADC SPI sclk line
    
	 output ADC_RESET,			// ADC reset line
    output ADC_SEN,				// ADC SPI CSB  line  
	 
// ============== Other interface =============		 
	 
    output  AFE_CAL,			// AFE calibration bits
    output  AFE_PICKUP,    // AFE pickup control bits
   // output  AFE_REC,       // AFE receiver control bits
  	 output [4:0] AFE_VGA_GAIN,
  
    //inout SDA,
	 //output SCL,
	 output att_le,    //DAT-31-R5 interface
	 output att_data,
	 output att_clk,
	 
	 output SMA_OUT,
    output OPTICAL_OUT,
    input OPTICAL_IN,
    input [1:0] SMA_IN,
	 output Trig_LED,
   
	
	 input CLK_10MHz,
	 input FPGA_RESET_BT
	 //output [7:0] LED
	
	 
  );

///////////////////////////////////////////////////////////////
//==================== Constant Parameters =================== 
/////////////////////////////////////////////////////////////// 
parameter FPGA_VERSION_NO = 32'd20170517; //May 16, 2017

parameter  	ADC_BIT_WIDTH = 16;
parameter  	DATA_WIDTH = 16;
parameter  	FIFO_DEPTH = 10;
parameter   SFIFO_WIDTH = 32;

parameter  	SF_WIDTH = 32;
 
parameter  	TAP_DELAY = 75;
parameter  	DATA_DELAY = 0;
parameter  	CLOCK_DELAY = 0;
parameter  	FRAME_DELAY = 0;
parameter  	PMAX = 14'h1B58;   // Dec 7000
parameter  	NMAX = 14'h24A8;   // Dec -7000 

/////////////// Global Signal ///////////////////////
wire gclk0;
wire clk; // = CLK_10MHz;

//control_reg[15] to be used for reset Buf_SigProcs module
reg soft_rst;
always @ (posedge clk) 
begin
	if (control_reg[15])	soft_rst <= 1; 
	else 	 soft_rst <= 0;
end

wire rst = soft_rst | FPGA_RESET_BT | RESET;

/////////////////////////////////////////////////////
//===============DCM components=====================
///////////////////////////////////////////////////

  clk_switch clkcross(  //don't fooled by its name, this is a PLL. 
    .CLK_IN1(CLK_10MHz), // IN, 
    .CLK_OUT1(clk),     // OUT
    .RESET(rst),// IN
    .LOCKED(LOCKED));      // OUT

//////////////////////////////////////////////////////
//====================== deserializer components=============
/////////////////////////////////////////////////////

wire [ADC_BIT_WIDTH-1:0] Aout_deser;
wire [ADC_BIT_WIDTH-1:0] Bout_deser;
wire [ADC_BIT_WIDTH-1:0] Cout_deser;
wire [ADC_BIT_WIDTH-1:0] Dout_deser;

ADC_des #(
	   .TAP_DELAY (TAP_DELAY),
	   .DATA_DELAY (DATA_DELAY),
		.CLOCK_DELAY (CLOCK_DELAY),
		.FRAME_DELAY (FRAME_DELAY),
		.PMAX (PMAX),
		.NMAX (NMAX) 
)ADC_des_inst (
    .DCHA({DA1_N,DA1_P,DA0_N,DA0_P}), 
    .DCHB({DB1_N,DB1_P,DB0_N,DB0_P}), 
    .DCHC({DC1_N,DC1_P,DC0_N,DC0_P}), 
    .DCHD({DD1_N,DD1_P,DD0_N,DD0_P}), 
    .DCLK({DCLK_N,DCLK_P}), 
    .FCLK({FCLK_N,FCLK_P}),
	 .data_A_out(Dout_deser), //A,B,C,D channel order mistakely reversed on the Digitizer board.
	 .data_B_out(Cout_deser),
	 .data_C_out(Bout_deser),
	 .data_D_out(Aout_deser),
	 .GCLK(gclk0)
    );

wire fifo_rd_ab;
wire fifo_rd_cd;

wire [4*ADC_BIT_WIDTH-1:0] fast_fifo_dout;
wire [FIFO_DEPTH-1:0] CD_fifo_word;
wire [FIFO_DEPTH-1:0] AB_fifo_word;


wire [SFIFO_WIDTH-1:0] slow_fifo_dout;

wire [DATA_WIDTH-1:0]status_net;

// auto_range
wire [4:0]auto_att_reg;

// skew factors
reg [SF_WIDTH-1:0] ChA_Skew;
reg [SF_WIDTH-1:0] ChC_Skew;

reg [DATA_WIDTH-1:0]control_reg;
reg [DATA_WIDTH-1:0]AFE_Control_Reg; 
reg [DATA_WIDTH-1:0]SPI_Addr_Reg;
reg [7:0]SPI_Data_Tx;
reg [7:0]SPI_Data_Rx;

reg [DATA_WIDTH-1:0] BPM_Dia;
reg [DATA_WIDTH-1:0] Trig_TH_Reg;
reg [DATA_WIDTH-1:0]	Trig_DT_Reg;
reg [DATA_WIDTH-1:0]	Trig_DL_Reg;
reg [DATA_WIDTH-1:0]	Evt_Len_Reg;  //Event Length in samples reg
reg [DATA_WIDTH-1:0] Evt_Tail_Len_Reg;  //Event tail length in samples reg
reg [DATA_WIDTH-1:0]	BL_Len_Reg; //Baseline Length: to be used to cal the BL

wire [SF_WIDTH-1:0] ChA_Power_reg;
wire [SF_WIDTH-1:0] ChB_Power_reg;
wire [SF_WIDTH-1:0] ChC_Power_reg;
wire [SF_WIDTH-1:0] ChD_Power_reg;
wire [DATA_WIDTH-1:0] X_reg,Y_reg,S_reg; 

reg [SF_WIDTH-1:0] CHA_GAIN;
reg [SF_WIDTH-1:0] CHB_GAIN;
reg [SF_WIDTH-1:0] CHC_GAIN;
reg [SF_WIDTH-1:0] CHD_GAIN;

reg [SF_WIDTH-1:0] CHA_CAL_GAIN;
reg [SF_WIDTH-1:0] CHB_CAL_GAIN;
reg [SF_WIDTH-1:0] CHC_CAL_GAIN;
reg [SF_WIDTH-1:0] CHD_CAL_GAIN;

reg [SF_WIDTH-1:0] ChA_9dB;
reg [SF_WIDTH-1:0] ChB_9dB;
reg [SF_WIDTH-1:0] ChC_9dB;
reg [SF_WIDTH-1:0] ChD_9dB;


reg [SF_WIDTH-1:0] K_CAL;
reg [SF_WIDTH-1:0] CAL_NFX;
reg [SF_WIDTH-1:0] CAL_NFY;

wire SigProcs_busy;
wire trig_out,cal_on;

wire sFIFO_rd;
wire [5:0] slow_fifo_wd;

//for 14 bit ADC, extend to 16 bit data, 2's complement format

//wire [DATA_WIDTH-1:0] Aout;
//wire [DATA_WIDTH-1:0] Bout;
//wire [DATA_WIDTH-1:0] Cout;
//wire [DATA_WIDTH-1:0] Dout;
//wire is_16Bit_ADC = control_reg[6]; //16 bit or 14 bit ADC
//assign Aout = is_16Bit_ADC? Aout_deser 
//            :{Aout_deser[13],Aout_deser[13],Aout_deser[13:0]};	
//assign Bout = is_16Bit_ADC? Bout_deser
//            :{Bout_deser[13],Bout_deser[13],Bout_deser[13:0]};				
//assign Cout = is_16Bit_ADC? Cout_deser 
//            :{Cout_deser[13],Cout_deser[13],Cout_deser[13:0]};				
//assign Dout = is_16Bit_ADC? Dout_deser
//            :{Dout_deser[13],Dout_deser[13],Dout_deser[13:0]};
	 
Buf_SigProcs Buf_SigProcs_inst (
//	.data_in({Dout,Cout,Bout,Aout}),	//data from deserializer, use this line for 14 bit digitizer, Aug.15,2016	 
	.data_in({Dout_deser,Cout_deser,Bout_deser,Aout_deser}),	//data from deserializer, this line works with 16 bit digitizer
	.gclk0(gclk0),   //ADC data clk, 100MHz ~ 125 MHz
	.clk(clk),     //slow processing clk, 1MHz ~ 10 MHz
	
	.MB_bus_Clk(MB2FPGA_bus_Clk), 
	.fifo_rd_ab(fifo_rd_ab),
	.fifo_rd_cd(fifo_rd_cd),
	.AB_fifo_word(AB_fifo_word),  
	.CD_fifo_word(CD_fifo_word),  
	.fast_fifo_dout(fast_fifo_dout), 
	
	.sFIFO_rd(sFIFO_rd),	
	.slow_fifo_wd(slow_fifo_wd),
	.slow_fifo_dout(slow_fifo_dout),
	
	.rst(rst),
	.ex_trig( SMA_IN[0]),
	.veto(SMA_IN[1]),
	
	.BPM_Dia(BPM_Dia),
	.X_reg(X_reg),
	.Y_reg(Y_reg),
	.S_reg(S_reg),
	
	.ChA_Power_reg(ChA_Power_reg),
	.ChB_Power_reg(ChB_Power_reg),
	.ChC_Power_reg(ChC_Power_reg),
	.ChD_Power_reg(ChD_Power_reg),
	
	.Trig_TH_Reg(Trig_TH_Reg),
	.Trig_DT_Reg(Trig_DT_Reg),
	.Trig_DL_Reg(Trig_DL_Reg),
	.Evt_Len_Reg(Evt_Len_Reg),  //Event Length in samples reg
   .Evt_Tail_Len_Reg(Evt_Tail_Len_Reg),  //Event tail length in samples reg
	.BL_Len_Reg(BL_Len_Reg),   //Baseline Length: to be used to cal the BL
	
	.ChA_Skew(ChA_Skew),
	.ChC_Skew(ChC_Skew),
	
	.ChA_Gain(CHA_GAIN),
	.ChB_Gain(CHB_GAIN),
	.ChC_Gain(CHC_GAIN),
	.ChD_Gain(CHD_GAIN),
	
	.ChA_9dB(ChA_9dB),
	.ChB_9dB(ChB_9dB),
	.ChC_9dB(ChC_9dB),
	.ChD_9dB(ChD_9dB),
	
	.ChA_Cal_Gain(CHA_CAL_GAIN),
	.ChB_Cal_Gain(CHB_CAL_GAIN),
	.ChC_Cal_Gain(CHC_CAL_GAIN),
	.ChD_Cal_Gain(CHD_CAL_GAIN),
	

	.K_cal(K_CAL),
	.DIGI_att(AFE_Control_Reg[13:9]),

	
	/* VGA gain controls */
	.existing_gain_reg(AFE_VGA_GAIN),
	.auto_att_reg(auto_att_reg),
	.VGA_gain(AFE_VGA_GAIN),
	
	.control_reg(control_reg),
	.status_net(status_net),
	
   .trig_out(trig_out),
	.cal_on(cal_on),
   .busy(SigProcs_busy) //to prevent the Fast fifo to be readout by MB

);




//============== MB to FPGA interface ====================  
// note Addr = 4*(SDK addr);
parameter integer 	BASE_ADDR = 32'h41710000;

parameter integer 	SR_ADDR = 4*16'h0000;
parameter integer 	CR_ADDR = 4*16'h0001;

parameter integer    FPGA_VER_ADDR = 4*16'h0002;  //FPGA version # 

parameter integer CHA_POWER_ADDR = 4*16'h0004;
parameter integer CHB_POWER_ADDR = 4*16'h0005;
parameter integer CHC_POWER_ADDR = 4*16'h0006;
parameter integer CHD_POWER_ADDR = 4*16'h0007;

parameter integer 	X_ADDR = 4*16'h0008;
parameter integer 	Y_ADDR = 4*16'h0009;
parameter integer 	S_ADDR = 4*16'h000A;
/*
parameter integer 	XAVER_ADDR = 4*16'h000B;
parameter integer 	YAVER_ADDR = 4*16'h000C;
parameter integer 	SAVER_ADDR = 4*16'h000D;
parameter integer 	SRAW_ADDR =  4*16'h000E;

*/
parameter integer 	TRIG_DL_ADDR = 4*16'h0016;
parameter integer 	BPM_DIA_ADDR = 4*16'h0017;
parameter integer 	TRIG_TH_ADDR = 4*16'h0018;
parameter integer 	TRIG_DT_ADDR = 4*16'h0019;
parameter integer 	EVT_LEN_ADDR = 4*16'h001A;
parameter integer 	EVT_TAIL_LEN_ADDR = 4*16'h001B;
parameter integer 	BL_LEN_ADDR = 4*16'h001C;
parameter integer 	AB_FIFO_WD_ADDR = 4*16'h001D;
parameter integer 	CD_FIFO_WD_ADDR = 4*16'h001E;

parameter integer 	S_FIFO_ADDR = 4*16'h0020;
parameter integer 	S_FIFO_WD_ADDR = 4*16'h0021;


parameter integer 	ABF_FIFO_ADDR = 4*16'h0028;
//parameter integer 	BF_FIFO_ADDR = 4*16'h0029;
parameter integer 	CDF_FIFO_ADDR = 4*16'h002A;
//parameter integer 	DF_FIFO_ADDR = 4*16'h002B;

parameter integer SPI_ADDR_ADDR = 4*16'h0030;
parameter integer SPI_DATA_TX_ADDR = 4*16'h0031;
parameter integer SPI_DATA_RX_ADDR = 4*16'h0032;

// Digital attenuation coefficient addresses
parameter integer 	ChA_9dB_ADDR = 4*16'h0042;
parameter integer 	ChB_9dB_ADDR = 4*16'h0046;
parameter integer 	ChC_9dB_ADDR = 4*16'h004A;
parameter integer 	ChD_9dB_ADDR = 4*16'h004E;

// Skew compensation coefficient addresses 
parameter integer		ChA_Skew_ADDR = 4*16'h0070;
parameter integer 	ChC_Skew_ADDR = 4*16'h0071;

parameter integer 	AFE_CTRL_ADDR = 4*16'h0058;
parameter integer 	ERR_REG_ADDR = 4*16'h005A;

parameter integer 	CHA_GAIN_ADDR = 4*16'h060;
parameter integer 	CHB_GAIN_ADDR = 4*16'h061;
parameter integer 	CHC_GAIN_ADDR = 4*16'h062;
parameter integer 	CHD_GAIN_ADDR = 4*16'h063;

parameter integer 	CHA_CAL_GAIN_ADDR = 4*16'h065;
parameter integer 	CHB_CAL_GAIN_ADDR = 4*16'h066;
parameter integer 	CHC_CAL_GAIN_ADDR = 4*16'h067;
parameter integer 	CHD_CAL_GAIN_ADDR = 4*16'h068;

parameter integer 	K_CAL_ADDR = 4*16'h06A;
parameter integer 	CAL_NFX_ADDR = 4*16'h06B;
parameter integer 	CAL_NFY_ADDR = 4*16'h06C;

// Actual vga_gain address
parameter integer		ACTUAL_VGA_GAIN_ADDR = 4*16'h06D;

reg [31:0] dout;

wire MB2FPGA_bus_Rst;
wire MB2FPGA_bus_En;
wire [3:0] MB2FPGA_bus_WE;
wire [31:0] MB2FPGA_bus_Addr; 
wire [31:0] MB2FPGA_bus_WrData;
wire [31:0] MB2FPGA_bus_RdData; 

assign fifo_rd_ab = (MB2FPGA_bus_Addr == (BASE_ADDR + ABF_FIFO_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
assign fifo_rd_cd = (MB2FPGA_bus_Addr == (BASE_ADDR + CDF_FIFO_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
assign sFIFO_rd = (MB2FPGA_bus_Addr == (BASE_ADDR + S_FIFO_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);


always@(posedge MB2FPGA_bus_Clk)
begin
/*   Write to Control Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CR_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					control_reg <= MB2FPGA_bus_WrData[15:0]; 		
		end

/*   Read from Control Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CR_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= control_reg; 
			dout[31:16] <= {16{control_reg[15]}};			
	end
	
/*   Read from FPGA version Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + FPGA_VER_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= FPGA_VERSION_NO; 
				
	end
	

/*   Write to BPM_Dia Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + BPM_DIA_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					BPM_Dia <= MB2FPGA_bus_WrData[15:0]; 		
		end

/*   Read from BPM_Dia Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + BPM_DIA_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= BPM_Dia; 
			dout[31:16] <= {16'b0};			
	end
/////////////read	power to test position
	
/*   Read from A_power Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHA_POWER_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[31:0] <= ChA_Power_reg; 		
	end
	
/*   Read from B_power Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHB_POWER_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[31:0] <= ChB_Power_reg; 			
	end
	
/*   Read from C_power Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHC_POWER_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[31:0] <= ChC_Power_reg; 				
	end
	
/*   Read from D_power Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHD_POWER_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[31:0] <= ChD_Power_reg; 			
	end
/*   Read from position_X Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + X_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= X_reg; 
			dout[31:16] <= {16'b0};	 			
	end

/*   Read from position_Y Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + Y_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= Y_reg; 
			dout[31:16] <= {16'b0};				
	end

/*   Read from S Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + S_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= S_reg; 
			dout[31:16] <= {16'b0};				
	end	

	
/*   Write to  Trig_TH_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_TH_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					Trig_TH_Reg <= MB2FPGA_bus_WrData[15:0]; 		
		end

/*   Read from  Trig_TH_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_TH_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= Trig_TH_Reg; 
			dout[31:16] <= {16'b0};	  		
		end	
		 
/*   Write to  Trig_DT_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_DT_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					Trig_DT_Reg <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   Read from  Trig_DT_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_DT_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= Trig_DT_Reg; 
			dout[31:16] <= {16'b0};	  	
		end	

/*   Write to  Trig_DL_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_DL_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					Trig_DL_Reg <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   Read from  Trig_DL_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_DL_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= Trig_DL_Reg; 
			dout[31:16] <= {16'b0};	  	
		end	
		
		
/*   Write to  Evt_Len_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + EVT_LEN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					Evt_Len_Reg <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   Read from  Evt_Len_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + EVT_LEN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= Evt_Len_Reg; 
			dout[31:16] <= {16'b0};		
		end
		
/*   Write to  Evt_Tail_Len_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + EVT_TAIL_LEN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					Evt_Tail_Len_Reg <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   read from Evt_Tail_Len_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + EVT_TAIL_LEN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= Evt_Tail_Len_Reg; 
			dout[31:16] <= {16'b0};			
		end
		
/*   Write to  BL_Len_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + BL_LEN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					BL_Len_Reg <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   Read from  BL_Len_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + BL_LEN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= 	BL_Len_Reg; 
			dout[31:16] <= {16'b0};			 		
		end
		
/*   Read from Status Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + SR_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= status_net; 
			dout[31:16] <= {16{status_net[15]}};				
	end	
	
/*   Write to AFE Control Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + AFE_CTRL_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					AFE_Control_Reg <= MB2FPGA_bus_WrData[15:0]; 		
	end
/*   Read from  AFE Control Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + AFE_CTRL_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= AFE_Control_Reg; 
			dout[31:16] <= {16{AFE_Control_Reg[15]}};
   end	
	
/*   Write to  SPI_Addr_Reg Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + SPI_ADDR_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					SPI_Addr_Reg <= MB2FPGA_bus_WrData[15:0]; 		
		end
		
/*   Write to  SPI_Data_Tx Register   */
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + SPI_DATA_TX_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					SPI_Data_Tx <= MB2FPGA_bus_WrData[7:0]; 		
		end	
		
/*   Read from SPI_Data_Rx Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + SPI_DATA_RX_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= {8'b0,SPI_Data_Rx}; 
			dout[31:16] <= {16'b0};				
	end
	
/*   Read from AB_fifo word Register   */	
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + AB_FIFO_WD_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= {5'b0,AB_fifo_word}; 
			dout[31:16] <= {16'b0};				
	end
/*   Read from CD_fifo word Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CD_FIFO_WD_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= {5'b0,CD_fifo_word}; 
			dout[31:16] <= {16'b0};				
	end
	
/*   Read Channel A and B fifo data   */	
	if ( fifo_rd_ab ) begin
			dout[15:0] <= fast_fifo_dout[15:0]; 
			dout[31:16] <= fast_fifo_dout[31:16];		
	end

/*   Read Channel C  and D fifo data   */	
	if ( fifo_rd_cd) begin
			dout[15:0] <= fast_fifo_dout[47:32]; 
			dout[31:16] <= fast_fifo_dout[63:48];	
	end

/*   Read from slow fifo word    */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + S_FIFO_WD_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= {10'b0,slow_fifo_wd}; 
			dout[31:16] <= {16'b0};				
	end
	
/*   Read from slow fifo    */		
	else if (sFIFO_rd ) begin
			dout <= slow_fifo_dout; 					
	end
			  
			
// write to channel gain ABCD//
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHA_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHA_GAIN <= MB2FPGA_bus_WrData; 		
	end
	
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHB_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHB_GAIN <= MB2FPGA_bus_WrData; 		
	end
	
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHC_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHC_GAIN <= MB2FPGA_bus_WrData; 		
	end
	
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHD_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHD_GAIN <= MB2FPGA_bus_WrData; 		
	end
	
//read from channel gain ABCD//

	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHA_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CHA_GAIN; 
		
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHB_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CHB_GAIN; 
		 
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHC_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CHC_GAIN; 
		 	
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHD_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CHD_GAIN; 
	 	
	end

//write to calibration gain ABCD//
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHA_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHA_CAL_GAIN <= MB2FPGA_bus_WrData; 		
	end
	
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHB_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHB_CAL_GAIN <= MB2FPGA_bus_WrData; 		
	end
	
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHC_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHC_CAL_GAIN <= MB2FPGA_bus_WrData; 		
	end

	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHD_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CHD_CAL_GAIN <= MB2FPGA_bus_WrData; 		
	end
	
////////////////////////////////////////////////////////////	
// write to ChA_XdB
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChA_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) ChA_9dB <= MB2FPGA_bus_WrData; 		
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChB_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) ChB_9dB <= MB2FPGA_bus_WrData; 		
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChC_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) ChC_9dB <= MB2FPGA_bus_WrData; 		
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChD_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) ChD_9dB <= MB2FPGA_bus_WrData; 		
// read from ChA_XdB	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChA_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) dout <= 	ChA_9dB; 	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChB_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) dout <= 	ChB_9dB; 	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChC_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) dout <= 	ChC_9dB; 	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChD_9dB_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) dout <= 	ChD_9dB;

////////////////////////////////////////////////////////////	
// write to ChX_Skew
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChA_Skew_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) ChA_Skew <= MB2FPGA_bus_WrData;
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChC_Skew_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) ChC_Skew <= MB2FPGA_bus_WrData;
// read from ChX_Skew	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChA_Skew_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) dout <= 	ChA_Skew;
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ChC_Skew_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) dout <= 	ChC_Skew;

///////////////////////////////////////////////////////////////
//write to constant K_cal//
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + K_CAL_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				K_CAL <= MB2FPGA_bus_WrData; 		
	end
	
//write to constant CAL_NFX//
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CAL_NFX_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CAL_NFX <= MB2FPGA_bus_WrData; 		
	end
	
//write to constant CAL_NFY//
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + CAL_NFY_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
				CAL_NFY <= MB2FPGA_bus_WrData; 		
	end	
	
	
//read from calibration gain ABCD//

	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHA_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout<= 	CHA_CAL_GAIN; 
	 		
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHB_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CHB_CAL_GAIN; 
		 	
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHC_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CHC_CAL_GAIN; 
			
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CHD_CAL_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CHD_CAL_GAIN; 
	 
	end
	
//read from calibration CAL_K, CAL_NFX,CAL_NFY//

	if ((MB2FPGA_bus_Addr == (BASE_ADDR + K_CAL_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout<= 	K_CAL; 
	 		
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CAL_NFX_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CAL_NFX; 
		 	
	end
	
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + CAL_NFY_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	CAL_NFY; 
			
	end

// read actual vga_gain from register
	if ((MB2FPGA_bus_Addr == (BASE_ADDR + ACTUAL_VGA_GAIN_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout <= 	AFE_VGA_GAIN; 
			
	end
	
	
end //always
 
assign MB2FPGA_bus_RdData = dout;

  (* BOX_TYPE = "user_black_box" *)
  mb_system
    mb_system_i (
      .zio ( zio ),
      .rzq ( rzq ),
      .mcbx_dram_we_n ( mcbx_dram_we_n ),
      .mcbx_dram_udqs_n ( mcbx_dram_udqs_n ),
      .mcbx_dram_udqs ( mcbx_dram_udqs ),
      .mcbx_dram_udm ( mcbx_dram_udm ),
      .mcbx_dram_ras_n ( mcbx_dram_ras_n ),
      .mcbx_dram_odt ( mcbx_dram_odt ),
      .mcbx_dram_ldm ( mcbx_dram_ldm ),
      .mcbx_dram_dqs_n ( mcbx_dram_dqs_n ),
      .mcbx_dram_dqs ( mcbx_dram_dqs ),
      .mcbx_dram_dq ( mcbx_dram_dq ),
      .mcbx_dram_ddr3_rst ( mcbx_dram_ddr3_rst ),
      .mcbx_dram_clk_n ( mcbx_dram_clk_n ),
      .mcbx_dram_clk ( mcbx_dram_clk ),
      .mcbx_dram_cke ( mcbx_dram_cke ),
      .mcbx_dram_cas_n ( mcbx_dram_cas_n ),
      .mcbx_dram_ba ( mcbx_dram_ba ),
      .mcbx_dram_addr ( mcbx_dram_addr ),
      .RS232_sout ( RS232_sout ),
      .RS232_sin ( RS232_sin ),
      .RS232_USB_sout ( RS232_USB_sout ),
      .RS232_USB_sin ( RS232_USB_sin ),
      .RESET ( RESET ),
      .Push_Buttons_3Bits_TRI_I ( Push_Buttons_3Bits_TRI_I ),
      .Linear_Flash_we_n ( Linear_Flash_we_n ),
      .Linear_Flash_reset ( Linear_Flash_reset ),
      .Linear_Flash_oe_n ( Linear_Flash_oe_n ),
      .Linear_Flash_data ( Linear_Flash_data ),
      .Linear_Flash_ce_n ( Linear_Flash_ce_n ),
      .Linear_Flash_address ( Linear_Flash_address ),
      .LEDs_8Bits_TRI_O ( LEDs_8Bits_TRI_O ),
      .Ethernet_Lite_TX_EN ( Ethernet_Lite_TX_EN ),
      .Ethernet_Lite_TX_CLK ( Ethernet_Lite_TX_CLK ),
      .Ethernet_Lite_TXD ( Ethernet_Lite_TXD ),
      .Ethernet_Lite_RX_ER ( Ethernet_Lite_RX_ER ),
      .Ethernet_Lite_RX_DV ( Ethernet_Lite_RX_DV ),
      .Ethernet_Lite_RX_CLK ( Ethernet_Lite_RX_CLK ),
      .Ethernet_Lite_RXD ( Ethernet_Lite_RXD ),
      .Ethernet_Lite_PHY_RST_N ( Ethernet_Lite_PHY_RST_N ),
      .Ethernet_Lite_MDIO ( Ethernet_Lite_MDIO ),
      .Ethernet_Lite_MDC ( Ethernet_Lite_MDC ),
      .Ethernet_Lite_CRS ( Ethernet_Lite_CRS ),
      .Ethernet_Lite_COL ( Ethernet_Lite_COL ),
      .DIP_Switches_8Bits_TRI_I ( DIP_Switches_8Bits_TRI_I ),
      .CLK ( CLK ),
      .axi_bram_ctrl_0_BRAM_Rst_A_pin ( MB2FPGA_bus_Rst ),
      .axi_bram_ctrl_0_BRAM_Clk_A_pin ( MB2FPGA_bus_Clk ),
      .axi_bram_ctrl_0_BRAM_WrData_A_pin ( MB2FPGA_bus_WrData ),
      .axi_bram_ctrl_0_BRAM_Addr_A_pin ( MB2FPGA_bus_Addr ),
      .axi_bram_ctrl_0_BRAM_RdData_A_pin ( MB2FPGA_bus_RdData ),
      .axi_bram_ctrl_0_BRAM_En_A_pin ( MB2FPGA_bus_En ),
      .axi_bram_ctrl_0_BRAM_WE_A_pin ( MB2FPGA_bus_WE )
    );


//==================================================================================
//LED LED_inst(
//    .trig(trig_out),
//    .clk(clk),
//    .rst(rst),
//    .LED(Trig_LED)
//);
assign Trig_LED = 0;


//==============================================
DAT31 DAT31_inst(
	.clk(clk), //10MHz clk
	.rst(rst),

	.write(), //one clk wide pulse,100ns
	
	.att_le(att_le),
	.att_clk(att_clk),
	.att_data(att_data),
	
	.setting(AFE_Control_Reg[13:8])
);

//=================================================================================
//SPI module: never tested, 08152016SL
//SPI read/write notes:
//set 1 to SPI_Addr_Reg[15]/[14] to start write/read operation, then
//clear these two bits to 0 before next time operation!

wire SPI_wr = SPI_Addr_Reg[15];
wire SPI_rd = SPI_Addr_Reg[14];

wire SPI_data_rdy;
wire [7:0] spi_data_rcv;
always @ (posedge clk)
  if (SPI_data_rdy) SPI_Data_Rx <= spi_data_rcv;
  
SPI_Master SPI_inst(
    .clk(clk),
	 .rst(rst),
	 .addr_tx(SPI_Addr_Reg[12:0]), //13 bit addr
	 .data_tx(SPI_Data_Tx), //8 bit data sent to ADC
	 .data_rx(spi_data_rcv), //8 bit data received from ADC
	 .wr(wr_SPI),
	 .rd(rd_SPI),
	 .rdy(SPI_data_rdy),
	 .SCLK(), //SCLK),
	 .SDIO(), //SDATA),
	 .CSB()   //ADC_SEN)
);

assign SDATA = 0;                    // Test patterns:   0- normal operation
assign SCLK  = 0;                      // 					  1- SYNC pattern
assign ADC_SEN = 0;

assign ADC_RESET = 0;
 
assign OPTICAL_OUT = OPTICAL_IN;
assign SMA_OUT = control_reg[3]? ~trig_out
               :1; //on SMA_OUT path, there's a NAND gate SN74S140
					
assign AFE_PICKUP = control_reg[13]? 1 //the "AFE_PICKUP" default to be 0 to select signal path.
                  :cal_on; 
assign AFE_CAL = ~AFE_PICKUP; //the "AFE_CAL" default to be 1 to turn off cal signal

// auto_run enable
wire AUTO_MODE = control_reg[6]; // Ranging mode select (1 = auto, 0 = manual)

assign AFE_VGA_GAIN = AUTO_MODE? auto_att_reg : AFE_Control_Reg[4:0];	///< Assigns AFE_VGA_GAIN output with either auto_gain or 
																								///< existing gain value in AFE_Control_Reg
 
   
endmodule

