`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:02 01/18/2016 
// Design Name: 
// Module Name:    buffer-circuilar_buffer 
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

module circuilar_buffer(
	input [15:0] dataAin,
	input CLK,
	input enable,
	output [15:0] dataAout
  );
	 
	reg [9:0] addr_count = 10'b0;

	always @ (posedge CLK)
	begin
		if(enable == 1'b1)begin
			addr_count <= addr_count + 10'b0000000001;
			if(addr_count[9] == 1'b1)begin
				addr_count[9] <= 1'b0;
			end 
		end 
	end
	
	
circular_buffer buffer_test (
  .clka(CLK), // input clka
  .wea(enable), // input [0 : 0] wea
  .addra(addr_count[8:0]), // input [8 : 0] addra
  .dina(dataAin), // input [15 : 0] dina
  .douta(dataAout) // output [15 : 0] douta
);


endmodule
