`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Angela Zhou
// 
// Create Date:    15:49:15 03/17/2016 
// Design Name: 
// Module Name:    pulse_strecher 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//	strech fast trig to wTrig. gclk0 = 100MHZ, clk = 10MHZ
// Dependencies: 
//	to stretch the length of trig when it's high, so that the slow clock can catch it 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pulse_strecher(
	input trig,
	input gclk0,
	output reg wTrig
    );
	 
reg [2:0] cnt;

always @ (posedge gclk0)
  begin
    if (trig) begin wTrig <= 1; cnt <= 0; end
	 else 
	   begin 
	       cnt <= cnt + 1;
			 if (cnt >= 11) wTrig <=0;   
		end
  end

endmodule
