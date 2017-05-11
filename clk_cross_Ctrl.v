`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:08:50 03/01/2016 
// Design Name: 
// Module Name:    clk_cross_Ctrl 
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
module clk_cross_Ctrl(
	input done,
	input clk,
	input p_clk,
	input rst,
	input empty1,
	input empty2,
	output reg rd,
	output reg wr_en,
	output reg event_rdy
    );

reg [2:0] state_init = 3'b000;
reg [2:0] state_wait1 = 'b001;
reg [2:0] state_wr = 3'b010;
reg [2:0] state_wait2 = 3'b011;
reg [2:0] state_done = 3'b100;
reg [2:0] state;

always@(posedge clk)
begin
	if(rst)
	begin
		state <= state_init;
		wr_en <= 0;
		rd <= 0;
		event_rdy <= 0;
	end
	
	else 
	begin
		case(state)
	
		state_init:
		if(done)
		begin
			//wr_en <= 1;
			rd <= 1;
			state <= state_wait1;
		end
	state_wait1:
		begin
			wr_en <= 1;
			state <= state_wr;
		end
		
		state_wr:
		if(empty1)
		begin
			event_rdy <= 1;
			rd <= 0;
			state <= state_wait2;
		end
		
		state_wait2:
		begin
			wr_en <= 0;
			state <= state_done;
		end
		
		state_done:
			if(empty2)
			begin
				event_rdy <= 0;
			end
		
		default: 
		begin
			state <= state_init;
			wr_en <= 0;
			rd <= 0;
			event_rdy <= 0;
			
		end
		endcase
	end
end





endmodule
