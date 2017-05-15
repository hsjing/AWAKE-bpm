`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        TRIUMF
// Engineer:       Victor Verzilov
// 
// Create Date:    16/7/2012 
// Design Name:    TRIUMF e-linac Beam Position Monitor IF processor 
// Module Name:    mb_system_top
// Project Name: 
// Target Devices: xc6slx150t-3fgg676
// Tool versions:  ISE 13.3
// Description: 
//
// Dependencies:
// Revision: 7.4.3 Buffer write enable/disable logic is revised.
// Revision: 7.4.2 Trigger watchdog addes. Error codes are revised.
// Revision: 7.4.1 CCD FIFO 211 bit wide is used to cross the boundary rather then individula fifos fow each varaiable.
// Revision: 7.4.0 FIFO implemented to cross clock domains 
// Revision: 7.3.2 1024 sample 16-bit buffers were implemented for X_inst, Y_inst, S_inst, S_raw and time stamp.
// Revision: 7.3.0 Clock multiplexer was implemented for writing to and reading from debug buffers 
// Revision: 7.1.1 assignment with sign extention to 24 bits was written in single line. 
// Revision: 6.0  include the full hardware description of Microblaze system and DSP using envelope detection
//
//////////////////////////////////////////////////////////////////////////////////
    
module mb_system_top
  (
  
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
  input FCLK_P,				// ADC frame clock						
  input FCLK_N,							
  input DCLK_P,				// ADC data clock       
  input DCLK_N,				      
  input DA0_P,					// Channel A data	
  input DA0_N,
  input DA1_P,						
  input DA1_N,				 			
  input DB0_P,					// Channel B data	   
  input DB0_N,						
  input DB1_P,				
  input DB1_N,						 
  input DC0_P,					// Channel C data
  input DC0_N,						 
  input DC1_P,						  
  input DC1_N,						 
  input DD0_P,					// Channel D data
  input DD0_N,					
  input DD1_P,			
  input DD1_N,							 
  output SDATA,            // ADC sdata line      
  output SCLK,  				// ADC sclk line
  output ADC_RESET,			// ADC reset line
  output ADC_SEN,				// ADC_SEN  line  
  input FPGA_RESET_BT,
  output [3:0] AFE_CAL,			// AFE calibration bits
  output [3:0] AFE_PICKUP,    // AFE pickup control bits
  output [3:0] AFE_REC,       // FAE receiver control bits
  output AFE_HI_GAIN,         // AFE gain control
  output VGAG[4:0],				// VGA gain bits
  output SMA_OUT,
  output OPTICAL_OUT,
  input OPTICAL_IN,
  input [1:0] SMA_IN,
  //output CLCKOUT_P,
  //output CLCKOUT_N,
  input CLK_SOCKET,
  output [25:0] HEADER1	 
  );

//===============   Digital Signal Processing  ===============
wire [15:0]status_net;
reg [15:0]control_reg;
wire avd_drdy_ABCD; 
wire [15:0]x_inst;
wire [15:0]y_inst;
wire [15:0]s_inst;
wire [15:0]s_raw;
wire [16:0]x_aver;
wire [16:0]y_aver;
wire [16:0]s_aver;
wire [23:0]dba_out;
wire [23:0]dbb_out;
wire [23:0]dbc_out;
wire [23:0]dbd_out;
wire glclk;
reg [7:0]db_mod;
wire db_wenbl;
wire trig_gate;
reg [13:0]ADC_OFST_A;
reg [15:0]ADC_GAIN_A;	 
reg [13:0]ADC_OFST_B;
reg [15:0]ADC_GAIN_B;	 
reg [13:0]ADC_OFST_C;
reg [15:0]ADC_GAIN_C;	 
reg [13:0]ADC_OFST_D;
reg [15:0]ADC_GAIN_D;
reg [15:0]NORF_DOS;
reg [15:0]NORF_SUM;
reg [15:0]THRESH;
reg [15:0]AFE_CTRL_REG; 
reg [15:0]MASK_REG;
	

avd_top avd_top_system (
    .FCLK_P(FCLK_P), 
    .FCLK_N(FCLK_N), 
    .DCLK_P(DCLK_P), 
    .DCLK_N(DCLK_N), 
    .DA0_P(DA0_P), 
    .DA0_N(DA0_N), 
    .DA1_P(DA1_P), 
    .DA1_N(DA1_N), 
    .DB0_P(DB0_P), 
    .DB0_N(DB0_N), 
    .DB1_P(DB1_P), 
    .DB1_N(DB1_N), 
    .DC0_P(DC0_P), 
    .DC0_N(DC0_N), 
    .DC1_P(DC1_P), 
    .DC1_N(DC1_N), 
    .DD0_P(DD0_P), 
    .DD0_N(DD0_N), 
    .DD1_P(DD1_P), 
    .DD1_N(DD1_N), 
	 .ADC_OFST_A(ADC_OFST_A),
	 .ADC_GAIN_A(16'd32768 + ADC_GAIN_A),		// Channel gain is the actual gain times 16'd32768	 
	 .ADC_OFST_B(ADC_OFST_B),
	 .ADC_GAIN_B(16'd32768 + ADC_GAIN_B),		// Channel gain is the actual gain times 16'd32768	 
	 .ADC_OFST_C(ADC_OFST_C),
	 .ADC_GAIN_C(16'd32768 + ADC_GAIN_C),		// Channel gain is the actual gain times 16'd32768	 
	 .ADC_OFST_D(ADC_OFST_D),
	 .ADC_GAIN_D(16'd32768 + ADC_GAIN_D),		// Channel gain is the actual gain times 16'd32768
	 .DBA_OUT(dba_out),
	 .DBB_OUT(dbb_out),
	 .DBC_OUT(dbc_out),
	 .DBD_OUT(dbd_out),	
	 .DB_MOD(db_mod),
	 .DB_WENBL(db_wenbl),
	 .NORF_DOS(16'd32768 + NORF_DOS),
	 .NORF_SUM(16'd32768 + NORF_SUM),
	 .THRESH(THRESH),
    .RESET(RESET),
	 .GLCLK0(glclk),
    .INS({SMA_IN[0],OPTICAL_IN}),
    .TRIG_OR(trig_gate),
	 .MASKS(MASK_REG),
    .CRLREG(control_reg), 
    .STSREG(status_net[6:0]), 
    .avd_drdy_ABCD(avd_drdy_ABCD), 
    .x_inst(x_inst), 
    .y_inst(y_inst), 
    .s_inst(s_inst),
	 .x_aver(x_aver),
	 .y_aver(y_aver),
	 .s_aver(s_aver),
	 .s_raw(s_raw),
	 .HEADER_NET(HEADER1),
	 .SWITCH(DIP_Switches_8Bits_TRI_I[7:0])
    );	 

//===================Time stamp counter ==================

 IBUFG #(
      .IOSTANDARD("DEFAULT")
   ) IBUFG_1MHz_clk (
      .O(CLK_10MHZ),         		 // Clock buffer output
      .I(CLK_SOCKET)              // Clock buffer input (connect directly to top-level port)
   );

reg [15:0] tmp_stmp;

always @ (posedge CLK_10MHZ)		
begin
	tmp_stmp <= tmp_stmp +1;
end

//=============== Trigger Occurance  Watchdog =============

reg [31:0] tim_cntr;
reg [31:0] dc_cntr;
reg notrig;

always @ (posedge CLK_10MHZ)		
begin
	tim_cntr <= tim_cntr + 1;
	if (trig_gate == 1) begin
		dc_cntr <= dc_cntr +  1;
	end
	if (tim_cntr == 32'h00989680) begin
	     if ( dc_cntr == 32'h00000000) begin
				notrig <= 1'b1;
		  end
		  else begin
				notrig <= 1'b0;			
		  end
		   tim_cntr <= 0;
			dc_cntr <= 0; 
	end
end

assign status_net[7] = notrig;

//============== MB to FPGA interface ====================  
parameter integer 	BASE_ADDR = 32'h41710000;
parameter integer 	SR_ADDR = 16'h0000;
parameter integer 	CR_ADDR = 16'h0004;
parameter integer 	XINST_ADDR = 16'h0020;
parameter integer 	YINST_ADDR = 16'h0024;
parameter integer 	SINST_ADDR = 16'h0028;
parameter integer 	XAVER_ADDR = 16'h002C;
parameter integer 	YAVER_ADDR = 16'h0030;
parameter integer 	SAVER_ADDR = 16'h0034;
parameter integer 	SRAW_ADDR = 16'h0038;
parameter integer 	FIFO1_ADDR = 16'h0060;
parameter integer 	FIFO2_ADDR = 16'h0064;
parameter integer 	FIFO3_ADDR = 16'h0068;
parameter integer 	FIFO4_ADDR = 16'h006C;
parameter integer 	FIFO5_ADDR = 16'h0070;
parameter integer 	DBAOUT_ADDR = 16'h0080;
parameter integer 	DBBOUT_ADDR = 16'h0084;
parameter integer 	DBCOUT_ADDR = 16'h0088;
parameter integer 	DBDOUT_ADDR = 16'h008C;
parameter integer 	DBMOD_ADDR = 16'h0090;
parameter integer 	ADC_OFST_A_ADDR = 16'h0100;
parameter integer 	ADC_GAIN_A_ADDR = 16'h0104;
parameter integer 	ADC_OFST_B_ADDR = 16'h0108;
parameter integer 	ADC_GAIN_B_ADDR = 16'h010C;
parameter integer 	ADC_OFST_C_ADDR = 16'h0110;
parameter integer 	ADC_GAIN_C_ADDR = 16'h0114;
parameter integer 	ADC_OFST_D_ADDR = 16'h0118;
parameter integer 	ADC_GAIN_D_ADDR = 16'h011C;
parameter integer 	NORF_DOS_ADDR = 16'h0120;
parameter integer 	NORF_SUM_ADDR = 16'h0124;
parameter integer 	THRESH_ADDR = 16'h0128;
parameter integer 	AFE_CTRL_ADDR = 16'h0130;
parameter integer 	TRIG_MASK_ADDR = 16'h0134;
parameter integer 	DBAFIFO_ADDR = 16'h00A0;
parameter integer 	DBBFIFO_ADDR = 16'h00A4;
parameter integer 	DBCFIFO_ADDR = 16'h00A8;
parameter integer 	DBDFIFO_ADDR = 16'h00AC;


wire [15:0]fifo_1;
wire [15:0]fifo_2;
wire [15:0]fifo_3;
wire [15:0]fifo_4;
wire [15:0]fifo_5;

wire fifo_renbl_1;
wire fifo_renbl_2;
wire fifo_renbl_3;
wire fifo_renbl_4;
wire fifo_renbl_5;

wire [23:0]fifo_dout_a;
wire [23:0]fifo_dout_b;
wire [23:0]fifo_dout_c;
wire [23:0]fifo_dout_d;

wire fifo_renbl_a;
wire fifo_renbl_b;
wire fifo_renbl_c;
wire fifo_renbl_d;

reg fifo_wenbl;

wire [15:0]ccd_x_inst;
wire [15:0]ccd_y_inst;
wire [15:0]ccd_s_inst;
wire [15:0]ccd_s_raw;
wire [16:0]ccd_x_aver;
wire [16:0]ccd_y_aver;
wire [16:0]ccd_s_aver;
wire [23:0]ccd_dba_out;
wire [23:0]ccd_dbb_out;
wire [23:0]ccd_dbc_out;
wire [23:0]ccd_dbd_out;

  reg [31:0] dout;
  
  wire MB2FPGA_bus_Rst;
  wire MB2FPGA_bus_Clk;
  wire MB2FPGA_bus_En;
  wire [3:0] MB2FPGA_bus_WE;
  wire [31:0] MB2FPGA_bus_Addr; 
  wire [31:0] MB2FPGA_bus_WrData;
  wire [31:0] MB2FPGA_bus_RdData; 

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
/*   Read from Status Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + SR_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= status_net; 
			dout[31:16] <= {16{status_net[15]}};				
	end	
/*   Read instaneous x-position   */
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + XINST_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= ccd_x_inst;//16'd55; 
			dout[31:16] <= {16{ccd_x_inst[15]}};	
		end
/*   Read instaneous y-position   */		
	else	if ((MB2FPGA_bus_Addr == (BASE_ADDR + YINST_ADDR)) & (MB2FPGA_bus_En == 1)) begin
			dout[15:0] <= ccd_y_inst; //-16'd66;
			dout[31:16] <= {16{ccd_y_inst[15]}};	
		end	
/*   Read instaneous intensity   */		
	else	if ((MB2FPGA_bus_Addr == (BASE_ADDR + SINST_ADDR)) & (MB2FPGA_bus_En == 1)) begin
			dout[15:0] <= ccd_s_inst; //-16'd66;
			dout[31:16] <= {16{ccd_s_inst[15]}};				
		end
/*   Read average x-position   */
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + XAVER_ADDR)) & (MB2FPGA_bus_En == 1) ) begin
			dout[16:0] <= ccd_x_aver;//16'd55; 
			dout[31:17] <= {15{ccd_x_aver[16]}};	
		end
/*   Read average y-position   */		
	else	if ((MB2FPGA_bus_Addr == (BASE_ADDR + YAVER_ADDR)) & (MB2FPGA_bus_En == 1)) begin
			dout[16:0] <= ccd_y_aver; //-16'd66;
			dout[31:17] <= {15{ccd_y_aver[16]}};	
		end	
/*   Read average intensity   */		
	else	if ((MB2FPGA_bus_Addr == (BASE_ADDR + SAVER_ADDR)) & (MB2FPGA_bus_En == 1)) begin
			dout[16:0] <= ccd_s_aver; //-16'd66;
			dout[31:17] <= {15{ccd_s_aver[16]}};				
		end	
/*   Read raw intensity   */		
	else	if ((MB2FPGA_bus_Addr == (BASE_ADDR + SRAW_ADDR)) & (MB2FPGA_bus_En == 1)) begin
			dout[15:0] <= ccd_s_raw; //-16'd66;
			dout[31:16] <= {16{ccd_s_raw[15]}};				
		end		
/*   Write to Channel A Offset Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_A_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_OFST_A <= MB2FPGA_bus_WrData[13:0]; 		
		end
/*   Read from Channel A Offset Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_A_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[13:0] <= ADC_OFST_A; 
			dout[31:14] <= {18{ADC_OFST_A[13]}};				
	end
/*   Write to Channel B Offset Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_B_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_OFST_B <= MB2FPGA_bus_WrData[13:0]; 		
		end
/*   Read from Channel B Offset Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_B_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[13:0] <= ADC_OFST_B; 
			dout[31:14] <= {18{ADC_OFST_B[13]}};	
	end
/*   Write to Channel C Offset Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_C_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_OFST_C <= MB2FPGA_bus_WrData[13:0]; 		
		end
/*   Read from Channel C Offset Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_C_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[13:0] <= ADC_OFST_C; 
			dout[31:14] <= {18{ADC_OFST_C[13]}};	
	end
/*   Write to Channel D Offset Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_D_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_OFST_D <= MB2FPGA_bus_WrData[13:0]; 		
		end
/*   Read from Channel D Offset Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_OFST_D_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[13:0] <= ADC_OFST_D; 
			dout[31:14] <= {18{ADC_OFST_D[13]}};	
	end
/*   Write to Difference over Sum normalization Factor Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + NORF_DOS_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					NORF_DOS <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   Read from Difference over Sum normalization Factor Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + NORF_DOS_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= NORF_DOS; 
			dout[31:16] <= {16{NORF_DOS[15]}};				
	end	
/*   Write to Total Intensity normalization Factor Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + NORF_SUM_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					NORF_SUM <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   Read from Total Intensity normalization Factor Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + NORF_SUM_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= NORF_SUM; 
			dout[31:16] <= {16{NORF_SUM[15]}};				
	end
/*   Write to Trigger Threshold Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + THRESH_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					THRESH <= MB2FPGA_bus_WrData[15:0]; 		
		end
/*   Read from Trigger Threshold Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + THRESH_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= THRESH; 
			dout[31:16] <= {16{THRESH[15]}};
	end	
/*   Write to Debug Mode Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + DBMOD_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					db_mod <= MB2FPGA_bus_WrData[7:0]; 		
	end
/*   Read from Debug Mode Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + DBMOD_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[7:0] <= db_mod; 
			dout[31:8] <= {24{db_mod[7]}};			
	end
/*   Write to Channel A Gain Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_A_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_GAIN_A <= MB2FPGA_bus_WrData[15:0]; 		
	end
/*   Read from  Channel A Gain Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_A_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= ADC_GAIN_A; 
			dout[31:16] <= {16{ADC_GAIN_A[15]}};
   end	
/*   Write to Channel B Gain Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_B_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_GAIN_B <= MB2FPGA_bus_WrData[15:0]; 		
	end
/*   Read from  Channel B Gain Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_B_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= ADC_GAIN_B; 
			dout[31:16] <= {16{ADC_GAIN_B[15]}};
   end
/*   Write to Channel C Gain Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_C_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_GAIN_C <= MB2FPGA_bus_WrData[15:0]; 		
	end
/*   Read from  Channel C Gain Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_C_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= ADC_GAIN_C; 
			dout[31:16] <= {16{ADC_GAIN_C[15]}};
   end
/*   Write to Channel D Gain Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_D_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					ADC_GAIN_D <= MB2FPGA_bus_WrData[15:0]; 		
	end
/*   Read from  Channel D Gain Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + ADC_GAIN_D_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= ADC_GAIN_D; 
			dout[31:16] <= {16{ADC_GAIN_D[15]}};
   end

/*   Write to AFE Control Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + AFE_CTRL_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					AFE_CTRL_REG <= MB2FPGA_bus_WrData[15:0]; 		
	end
/*   Read from  AFE Control Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + AFE_CTRL_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= AFE_CTRL_REG; 
			dout[31:16] <= {16{AFE_CTRL_REG[15]}};
   end	
	
/*   Write to Mask Register   */		
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_MASK_ADDR)) & (MB2FPGA_bus_WE == 4'hF)  & (MB2FPGA_bus_En == 1) ) begin
					MASK_REG <= MB2FPGA_bus_WrData[15:0]; 		
	end
/*   Read from  Mask Register   */			
	else if ((MB2FPGA_bus_Addr == (BASE_ADDR + TRIG_MASK_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[15:0] <= MASK_REG; 
			dout[31:16] <= {16{MASK_REG[15]}};
   end	

/*   Read Channel A debug data   */	
	else if ( (MB2FPGA_bus_Addr == (BASE_ADDR + DBAOUT_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[23:0] <= ccd_dba_out; 
			dout[31:24] <= {8{ccd_dba_out[23]}};
	end	
/*   Read Channel B debug data   */	
	else if ( (MB2FPGA_bus_Addr == (BASE_ADDR + DBBOUT_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[23:0] <= ccd_dbb_out; 
			dout[31:24] <= {8{ccd_dbb_out[23]}};
	end
/*   Read Channel C debug data    */	
	else if ( (MB2FPGA_bus_Addr == (BASE_ADDR + DBCOUT_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[23:0] <= ccd_dbc_out; 
			dout[31:24] <= {8{ccd_dbc_out[23]}};
	end
/*   Read Channel D debug data    */	
	else if ( (MB2FPGA_bus_Addr == (BASE_ADDR + DBDOUT_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1) ) begin
			dout[23:0] <= ccd_dbd_out; 
			dout[31:24] <= {8{ccd_dbd_out[23]}};
	end	
	
/*   Read Channel A debug fifo data   */	
	if ( fifo_renbl_a ) begin
			dout[23:0] <= fifo_dout_a; 
			dout[31:24] <= {8{fifo_dout_a[23]}};		
	end
	
/*   Read Channel B debug fifo data   */	
	if ( fifo_renbl_b ) begin
			dout[23:0] <= fifo_dout_b; 
			dout[31:24] <= {8{fifo_dout_b[23]}};	
	end	
	
/*   Read Channel C debug fifo data   */	
	if ( fifo_renbl_c ) begin
			dout[23:0] <= fifo_dout_c; 
			dout[31:24] <= {8{fifo_dout_c[23]}};		
	end
/*   Read Channel D debug fifo data   */	
	if ( fifo_renbl_d ) begin
			dout[23:0] <= fifo_dout_d; 
			dout[31:24] <= {8{fifo_dout_d[23]}};	
	end

/*   Read  fifo #1 data   */	
	if ( fifo_renbl_1 ) begin
			dout[15:0] <= fifo_1; 
			dout[31:16] <= {16{fifo_1[15]}};			
	end

/*   Read  fifo #2 data   */	
	if ( fifo_renbl_2 ) begin
			dout[15:0] <= fifo_2; 
			dout[31:16] <= {16{fifo_2[15]}};			
	end

/*   Read  fifo #3 data   */	
	if ( fifo_renbl_3 ) begin
			dout[15:0] <= fifo_3; 
			dout[31:16] <= {16{fifo_3[15]}};			
	end

/*   Read  fifo #4 data   */	
	if ( fifo_renbl_4 ) begin
			dout[15:0] <= fifo_4; 
			dout[31:16] <= {16{fifo_4[15]}};			
	end

/*   Read  fifo #5 data   */	
	if ( fifo_renbl_5 ) begin
			dout[15:0] <= fifo_5; 
			dout[31:16] <= {16{1'b0}};			
	end	
	
end 
  
  
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
//================ Clock Cross Boundary FIFO ===================

ccd_dsp2mb ccd_dbd (
    .DIN({x_inst,y_inst,s_inst,s_raw,x_aver,y_aver,s_aver,dba_out,dbb_out,dbc_out,dbd_out}), 
    .WRCLK(glclk), 
    .RDCLK(MB2FPGA_bus_Clk), 
    .DOUT({ccd_x_inst,ccd_y_inst,ccd_s_inst,ccd_s_raw,ccd_x_aver,ccd_y_aver,ccd_s_aver,ccd_dba_out,ccd_dbb_out,ccd_dbc_out,ccd_dbd_out}), 
    .FIFULL(full_ccd_fifo)
    );
  assign status_net[12] = full_ccd_fifo;
	 
//============== Circular Buffers to store data ================

always @ (posedge glclk)		
begin
		if ( (control_reg[8] || (SMA_IN[1] & MASK_REG[4]) || ( OPTICAL_IN & MASK_REG[3])) == 1) begin         // Disable writing to buffers
			fifo_wenbl <= 1'b0;		
		end
		else if ( ((control_reg[8] && (SMA_IN[1] & MASK_REG[4]) && ( OPTICAL_IN & MASK_REG[3])) == 0)&&(control_reg[9] == 1)) begin         																	      // Enable writing to buffers
			fifo_wenbl <= 1'b1;		
		end		
end

assign status_net[8] = fifo_wenbl;

x5_16bit_fifo_buffer out_fifos_1k (
    .DIN1(x_inst), 
    .DIN2(y_inst), 
    .DIN3(s_inst), 
    .DIN4(s_raw), 
    .DIN5(tmp_stmp), 
    .WRCLK(glclk), 
    .RDCLK(MB2FPGA_bus_Clk), 
    .WENBL(fifo_wenbl), 
    .DTRDY(avd_drdy_ABCD), 
    .RENBL1(fifo_renbl_1), 
    .RENBL2(fifo_renbl_2), 
    .RENBL3(fifo_renbl_3), 
    .RENBL4(fifo_renbl_4), 
    .RENBL5(fifo_renbl_5), 
    .DOUT1(fifo_1), 
    .DOUT2(fifo_2), 
    .DOUT3(fifo_3), 
    .DOUT4(fifo_4), 
    .DOUT5(fifo_5)
    );
	 
	x4_24bit_fifo_buffer db_fifos_4k (
    .DINA(dba_out), 
    .DINB(dbb_out), 
    .DINC(dbc_out), 
    .DIND(dbd_out), 
    .WRCLK(glclk), 
    .RDCLK(MB2FPGA_bus_Clk), 
    .WENBL(fifo_wenbl), 
    .DTRDY(control_reg[10]), 
    .RENBLA(fifo_renbl_a), 
    .RENBLB(fifo_renbl_b), 
    .RENBLC(fifo_renbl_c), 
    .RENBLD(fifo_renbl_d), 
    .DOUTA(fifo_dout_a), 
    .DOUTB(fifo_dout_b), 
    .DOUTC(fifo_dout_c), 
    .DOUTD(fifo_dout_d)
    ); 
	 
  assign fifo_renbl_1 = (MB2FPGA_bus_Addr == (BASE_ADDR + FIFO1_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
  assign fifo_renbl_2 = (MB2FPGA_bus_Addr == (BASE_ADDR + FIFO2_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
  assign fifo_renbl_3 = (MB2FPGA_bus_Addr == (BASE_ADDR + FIFO3_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
  assign fifo_renbl_4 = (MB2FPGA_bus_Addr == (BASE_ADDR + FIFO4_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
  assign fifo_renbl_5 = (MB2FPGA_bus_Addr == (BASE_ADDR + FIFO5_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1); 

  assign fifo_renbl_a = (MB2FPGA_bus_Addr == (BASE_ADDR + DBAFIFO_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
  assign fifo_renbl_b = (MB2FPGA_bus_Addr == (BASE_ADDR + DBBFIFO_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
  assign fifo_renbl_c = (MB2FPGA_bus_Addr == (BASE_ADDR + DBCFIFO_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);
  assign fifo_renbl_d = (MB2FPGA_bus_Addr == (BASE_ADDR + DBDFIFO_ADDR)) & (MB2FPGA_bus_WE == 4'h0)  & (MB2FPGA_bus_En == 1);

  assign db_wenbl = control_reg[10] ;
  assign status_net[10] = db_wenbl;

//==================================================================================

assign SDATA = control_reg[0];                     // Test patterns:   0- normal operation
assign SCLK  = control_reg[1];                     // 					  1- SYNC pattern
																	// 					  2- Power Down
																	// 					  3- DESKEW pattern
assign ADC_RESET = control_reg[2];
assign ADC_SEN =  control_reg[3];
//assign LEDs_8Bits_TRI_O = ~status_net[7:0];
assign OPTICAL_OUT = OPTICAL_IN;
//assign SMA_OUT = FPGA_RESET_BT | SMA_IN[1] | SMA_IN[0];
assign SMA_OUT = ~trig_gate;

assign AFE_CAL = AFE_CTRL_REG[3:0];
assign AFE_PICKUP = AFE_CTRL_REG[7:4];
assign AFE_REC =  AFE_CTRL_REG[11:8];
assign AFE_HI_GAIN = AFE_CTRL_REG[15];
assign VGAG[0] = 1'b0;
assign VGAG[1] = 1'b0;
assign VGAG[2] = AFE_CTRL_REG[12];
assign VGAG[3] = AFE_CTRL_REG[13];
assign VGAG[4] = AFE_CTRL_REG[14];


endmodule

