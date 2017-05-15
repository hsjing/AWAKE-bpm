`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:28 02/16/2013 
// Design Name: 
// Module Name:    ccd_dsp2mb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ccd_dsp2mb(
    input [210:0] DIN,
    input WRCLK,
    input RDCLK,
	 output [210:0] DOUT,
	 output FIFULL
    );

wire wr_en;

ccd_fifo ccd_fifo_dsp2mb (
  .rst(1'b0), 									// input rst
  .wr_clk(WRCLK), 							// input wr_clk
  .rd_clk(RDCLK), 							// input rd_clk
  .din(DIN), 									// input [210 : 0] din
  .wr_en(wr_en), 								// input wr_en
  .rd_en(1'b1), 								// input rd_en
  .dout(DOUT), 				      		// output [210 : 0] dout
  .full( ), 									// output full
  .empty(wr_en) 								// output empty
);

endmodule
