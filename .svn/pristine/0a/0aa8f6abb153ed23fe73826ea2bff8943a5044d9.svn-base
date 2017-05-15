`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:02 03/01/2016 
// Design Name: 
// Module Name:    Buf_Ctrl 
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
module Buf_Ctrl(
	input trig,
	input rst,
	input clk,
	input rd,
	input [8:0] FIFO_Occupency,
	output reg wr_en,
	output reg rd_en,
	output reg done
	
    );
parameter integer win_len = 100; //500ns 
parameter integer head_len = 10;//100ns
parameter integer state_init = 3'b000; //loading 100 leading length
parameter integer state_read = 3'b001; //writing in and reading out garbage
parameter integer state_load = 3'b010; //storing event
parameter integer state_done = 3'b011; //reading event
parameter integer state_out = 3'b100;

reg [2:0]state_FIFO;


always @ (posedge clk) 
begin
	
	if (rst) 
	begin
		state_FIFO <= state_init;
		wr_en <= 1;
		rd_en <= 0;	
		done <= 0;
	end
	
	else 
	begin
		case (state_FIFO)
		state_init:									//loading first 10 cycle 
		if(FIFO_Occupency > head_len-1)	//if init_time is great than 10 cycle then depends on trig is on or off 
		begin  
				if(trig)
				begin
					state_FIFO <= state_load;
				end
				else 
				begin
					state_FIFO <= state_read;
					rd_en <= 1;
				end
		end
		
		
		state_read:				//reading garbage values
		if(trig)
		begin
			state_FIFO <= state_load;
			rd_en <= 0;
		end 

		
		state_load:
		if(FIFO_Occupency > win_len-1)
		begin
			wr_en <= 0;
			done <= 1;
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

endmodule



