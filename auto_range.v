`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		TRIUMF
// Engineer:		Jing Huang
// 
// Create Date:		15:24:22 05/11/2017 
// Design Name:		
// Module Name:		auto_range 
// Project Name:		awake.bpm.firmware
// Target Devices: 	SPARTAN 6 LX150T
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

/*
  Module: auto_range
  
  Automatically determines the VGA attenuation for the next measurement
  depending on the received and processed signals from the four channels
  
  Inputs:
  		
  		clk - process to be clocked from PLL, as determined by PLL
		rst - reset flag
  		ready - ready status bit for channel data: 1 -> ready to be read
		max_result_valid - flag for valid max data, only when this is 1 should auto_range begin to manipulate range settings
  		[4:0] 	vga_in - 5 bit vga attenuation initial  
  		[15:0] 	signal_max_(a~d) - 16 bit signal amplitude calculated from <Max.v>
  	
  Outputs:
  		
  		[4:0] auto_att_reg - 5 bit vga attenuation final
  
  Parameters:
   
   		upper_threshold - upper amplitude threshold beyond which signals must be re-ranged
   		lower_threshold - lower amplitude threshold that justifies increasing VGA attenuation
   		data_width - bit size of incoming amplitude data
   		step - attenuation shift in dB 
		max - maximum attenuation in dB
   
  Registers:

   		[2:0]	step - shifted steps for range adjustment in binary, intreperted as decimal in dB
   		[data_width-1:0]	signal_max_all - storage register for overall maximum amplitude after program iteration
  
  See Also:
  
  		<Max.v>
		
  TODO:
		
		- Cosmetic changes (improve range finding logic, lessen range)
		- Think of ways to improve speed with better algorithm
		- Make thresholds modifiable from UI
 */
 
module auto_range(
	input clk,
	input rst,
	input ready,
	input max_result_valid,

	input [4:0] vga_in,
	input [15:0] signal_max_a,
	input [15:0] signal_max_b,
	input [15:0] signal_max_c,
	input [15:0] signal_max_d,

	output reg [4:0] auto_att_reg
    );

	parameter upper_threshold = 25000; // Full range of amplitude is 32768
	parameter lower_threshold = 15000; // Lower threshold roughly 3 dB less than upper threshold     
	parameter data_width = 16;
	parameter step = 2;
	parameter max = 30;

	reg [data_width-1:0] signal_max_all;

	always @ (posedge clk) begin
	 
		/* Reset parameters by maxing out attenuation */
		if(rst) begin
			auto_att_reg <= max;
			end
			 
		/* Otherwise check for position ready flag and begin processing */
		else if(ready && max_result_valid) begin

			signal_max_all <= signal_max_a; ///< Initialize signal_max_all as signal_max_a
		
			/* Comparatively loads the maximum signal from rest of the channels */
			if (signal_max_b[15:0] > signal_max_all)	signal_max_all <= signal_max_b;
			if (signal_max_c[15:0] > signal_max_all)	signal_max_all <= signal_max_c;
			if (signal_max_d[15:0] > signal_max_all)	signal_max_all <= signal_max_d;
			 
			/* Lower or increase VGA attenuation depending on signal_max_all relative to the corresponding thresholds */
			if (signal_max_all > upper_threshold) begin
				if (vga_in < max)		auto_att_reg <= vga_in + step;
				end
			else if (signal_max_all < lower_threshold) begin
				if (vga_in >= step)		auto_att_reg <= vga_in - step;
				end
			end
		end    	
endmodule    		
