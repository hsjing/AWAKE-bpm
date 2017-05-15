`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:41 11/03/2011 
// Design Name: 
// Module Name:    deser_data_16bit_pll 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// 14/11/2013 Revision 1.00 - Converted to differential DDR clock
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module deser_data_16bit_ddr(
	 input DATA0P,			                
	 input DATA0N,	
	 input DATA1P,		
	 input DATA1N,	 
	 input IOCLKP,
	 input IOCLKN,
	 input GCLK,
    input IOSTROBE,	
	 output [15:0] DATAOUT,
	 input RESET,
	 input DESERSYNC,
	 output DEBUG
    );

    parameter integer 	DESERF = 8;
	 parameter integer 	SIM_TAP_DELAY = 75;
	 parameter integer 	IDELAY_VALUE = 0;
	 
	 deser_data_8bit_ddr #(
    .DESERF  (DESERF),
	 .SIM_TAP_DELAY	(SIM_TAP_DELAY),
	 .IDELAY_VALUE    (IDELAY_VALUE)
) deser_data0 (
    .DATAP(DATA0P), 
    .DATAN(DATA0N), 
    .IOCLKP(IOCLKP), 
    .IOCLKN(IOCLKN), 
    .GCLK(GCLK), 
    .IOSTROBE(IOSTROBE), 
    .DATAOUT(DATAOUT[7:0]),
	 .RESET(RESET),
	 .DESERSYNC(DESERSYNC)
    );
	 
	 
deser_data_8bit_ddr #(
    .DESERF  (DESERF),
	 .SIM_TAP_DELAY	(SIM_TAP_DELAY),
	 .IDELAY_VALUE    (IDELAY_VALUE)
) deser_data1 (
    .DATAP(DATA1P), 
    .DATAN(DATA1N), 
    .IOCLKP(IOCLKP), 
    .IOCLKN(IOCLKN),  
    .GCLK(GCLK), 
    .IOSTROBE(IOSTROBE), 
    .DATAOUT(DATAOUT[15:8]),
	 .RESET(RESET),
	 .DESERSYNC(DESERSYNC)
    );

assign DEBUG = DATAOUT[15] | DATAOUT[14];		 

endmodule
