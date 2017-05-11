`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:04:06 01/20/2016 
// Design Name: 
// Module Name:    FIFO_data 
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
module FIFO_data(
//	input [35:0]control,
	//input trig,
	input wr_clk,
	input rd_clk,
	input [15:0] datain,
	input rst,
	output [15:0] dataout
);

parameter integer win_len = 100; //500ns 
parameter integer head_len = 10;//100ns
parameter integer state_init = 2'b00; //loading 100 leading length
parameter integer state_read = 2'b01; //writing in and reading out garbage
parameter integer state_load = 2'b10; //storing event
parameter integer state_done = 2'b11; //reading event

reg [1:0]state_FIFO;
reg wr_en;
reg rd_en;
reg [15:0] good_data;

wire [15:0] din;
wire [15:0] dout;

wire CLK;
wire [63:0] DATA;
wire TRIG0;
wire full;
wire wr_ack;
wire empty;
wire valid;
wire [9:0] wr_data_count;
wire [9:0] rd_data_count;

assign din = datain;
assign CLK = wr_clk;
assign DATA[15:0] = datain;
assign DATA[31:16] = dataout;
assign DATA[33:32] = state_FIFO;
assign DATA[49:34] = dout;
assign DATA[59:50] = wr_data_count;
assign DATA[60] = wr_en;
assign DATA[61] = rd_en;
assign DATA[62] = trig;
assign TRIG0 = 1;

/*
ila3 ila3_test (
    .CONTROL(control), // INOUT BUS [35:0]
    .CLK(CLK), // IN
    .DATA(DATA), // IN BUS [63:0]
    .TRIG0(TRIG0) // IN BUS [0:0]
);
*/


always @ (posedge wr_clk) begin
	
	if (rst) begin
		state_FIFO <= state_init;
		wr_en <= 1;
		rd_en <= 0;	
	end
	
	else begin
		case (state_FIFO)
		state_init:									//loading first 10 cycle 
		if(wr_data_count > head_len-1)begin  //if init_time is great than 10 cycle then depends on trig is on or off 
				if(trig)begin
					state_FIFO <= state_load;
				end
				else begin
					state_FIFO <= state_read;
					rd_en <= 1;
				end
		end
		else begin
		state_FIFO <= state_init;
		wr_en <= 1;
		rd_en <= 0;
		end
		
		
		state_read:				//reading garbage values
		if(trig)begin
			state_FIFO <= state_load;
			rd_en <= 0;
		end 
		
		else begin
		state_FIFO <= state_read;
		wr_en <= 1;
		rd_en <= 1;
		end
		
		state_load:
		if(wr_data_count > win_len-1)begin
			state_FIFO <= state_done;
			rd_en <= 1;
			wr_en <= 0;
		end
		
		else begin
		state_FIFO <= state_load;
		wr_en <= 1;
		rd_en <= 0;
		end
		
		state_done:
		if(wr_data_count < 1)begin
			state_FIFO <= state_init;
			wr_en <= 1;
			rd_en <= 0;
		end
		
		else begin
			wr_en <= 0;
			rd_en <= 1;
			good_data <= dout;
		end
		
		default:
		begin
		state_FIFO <= state_init;
		wr_en <= 1;
		rd_en <= 0;
		end
	 endcase
	end
end
			
FIFO_position your_instance_name (
  .rst(rst), // input rst
  .wr_clk(wr_clk), // input wr_clk
  .rd_clk(rd_clk), // input rd_clk
  .din(din), // input [15 : 0] din
  .wr_en(wr_en), // input wr_en
  .rd_en(rd_en), // input rd_en
  .dout(dout), // output [15 : 0] dout
  .full(full), // output full
  .wr_ack(wr_ack), // output wr_ack
  .empty(empty), // output empty
  .valid(valid), // output valid
  .rd_data_count(rd_data_count), // output [9 : 0] rd_data_count
  .wr_data_count(wr_data_count) // output [9 : 0] wr_data_count
);
assign dataout = good_data;
endmodule
