`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:06 03/01/2016 
// Design Name: 
// Module Name:    FIFO_Buf 
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
module FIFO_Buf(
	input [63:0] DATAIN,
	input TRIG,
	input CLK,
	input P_CLK,
	input RD,
	input RST,
	output EVENT_RDY,
	output EMPTY,
	output [63:0] DATAOUT
    );

wire wr_en1;
wire rd_en1;
wire wr_en2;
wire rd_en2;
wire rd;
wire [63:0] dout;
wire [8:0] FIFO_Occupency;
wire done;
wire empty1;
wire empty2;
reg [63:0] Din;

assign rd_Buf = rd_en1 | rd;
assign rd_clk_cross = EVENT_RDY & RD;

Buf_Ctrl FIFO_Buf_Ctrl (
	.trig(TRIG),
	.rst(RST),
	.clk(CLK),
	.rd(RD),
	.FIFO_Occupency(FIFO_Occupency),
	.wr_en(wr_en1),
	.rd_en(rd_en1),
	.done(done)
);

FIFO_data FIFO_data (
  .rst(RST), // input rst
  .wr_clk(CLK), // input wr_clk
  .rd_clk(CLK), // input rd_clk
  .din(DATAIN), // input [63 : 0] din
  .wr_en(wr_en1), // input wr_en
  .rd_en(rd_Buf), // input rd_en
  .dout(dout), // output [63 : 0] dout
  .full(full), // output full
  .wr_ack(wr_ack), // output wr_ack
  .empty(empty1), // output empty
  .valid(valid), // output valid
  .rd_data_count(rd_data_count), // output [8 : 0] rd_data_count
  .wr_data_count(FIFO_Occupency) // output [8 : 0] wr_data_count
);




clk_cross_Ctrl FIFO_clk_cross_ctrl(
	.done(done),
	.clk(CLK),
	.p_clk(P_CLK),
	.rst(RST),
	.empty1(empty1),
	.empty2(empty2),
	.rd(rd),
	.wr_en(wr_en2),
	.event_rdy(EVENT_RDY)
);
/*	 
always@(posedge CLK)
begin
	if(wr_en2) Din <= dout;
end	
*/


clk_cross clk_corss (
  .rst(RST), // input rst
  .wr_clk(CLK), // input wr_clk
  .rd_clk(P_CLK), // input rd_clk
  .din(dout), // input [63 : 0] din
  .wr_en(wr_en2), // input wr_en
  .rd_en(rd_clk_cross), // input rd_en
  .dout(DATAOUT), // output [63 : 0] dout
  .full(full), // output full
  .wr_ack(wr_ack), // output wr_ack
  .empty(empty2), // output empty
  .valid(valid), // output valid
  .rd_data_count(rd_data_count), // output [8 : 0] rd_data_count
  .wr_data_count(wr_data_count) // output [8 : 0] wr_data_count
);

assign EMPTY = empty2;
endmodule
