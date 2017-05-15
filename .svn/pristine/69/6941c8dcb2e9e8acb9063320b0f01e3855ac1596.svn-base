`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TRIUMF
// Engineer: Angela Zhou
// 
// Create Date:    10:34:53 01/13/2014 
// Design Name: 
// Module Name:    bpm_dsp_rev_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// modified ADC deserilizer code from Elinac BPM 8.5.3v
// it takes 4 channel LVDS data from AD9653 and outputs 4 channel 16 bit data
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ADC_des(
	 input [3:0] DCHA,
    input [3:0] DCHB,
    input [3:0] DCHC,
    input [3:0] DCHD,
	 input [1:0] DCLK,
	 input [1:0] FCLK,
	 output [15:0] data_A_out,
	 output [15:0] data_B_out,
	 output [15:0] data_C_out,
	 output [15:0] data_D_out,
	 output GCLK
    );

parameter integer 	TAP_DELAY = 75;
parameter integer 	DATA_DELAY = 0;
parameter integer 	CLOCK_DELAY = 0;
parameter integer 	FRAME_DELAY = 0;
parameter integer 	PMAX = 14'h1B58;   // Dec 7000
parameter integer 	NMAX = 14'h24A8;   // Dec -7000 


deser_ddr_clk #(                        // Generate required clocks for data deserializtion
    .DESERF  (8),
    .HALFDESERF (4),
	 .CLKDLY (CLOCK_DELAY)
) iob_clk (
    .DCLKP(DCLK[0]), 
    .DCLKN(DCLK[1]), 
//    .BUFFCLK(bfclk), 
    .BUFx1GCLK(bgclk0),  
//    .BUFx2GCLK(bx2gclk), 
    .DESERSTROBE(dstrobe), 
	 .BUFIODCLKP(iob_dclk_p),
    .BUFIODCLKN(iob_dclk_n),
    .RESET(1'b0)
    );
	 
assign GCLK = bgclk0;

wire [4:0] SYNCOK;

deser_data_x4CH_ddr #(                  // Deserialize data and synchronise them using Frame clock
    .DESERF  (8),
	 .TAP_DELAY	(TAP_DELAY),
	 .DATA_DELAY (DATA_DELAY),
	 .FRAME_DELAY (FRAME_DELAY)
)sync_and_deser_x4CH (
    .DFRPN(FCLK), 
    .DCHAPN(DCHA), 
    .DCHBPN(DCHB),
	 .DCHCPN(DCHC),
	 .DCHDPN(DCHD),
    .IOCLKP(iob_dclk_p), 
	 .IOCLKN(iob_dclk_n),
    .GCLK(bgclk0), 
    .IOSTROBE(dstrobe),	 
    .DCHAOUT(data_A_out), 
    .DCHBOUT(data_B_out),
    .DCHCOUT(data_C_out),
    .DCHDOUT(data_D_out),	 
    .RESET(1'b0), 
    .DEBUG(SYNCOK)
    );	 


endmodule
