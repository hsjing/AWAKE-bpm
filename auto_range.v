`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		TRIUMF
// Engineer:		Jing Huang
// 
// Create Date:		15:24:22 05/11/2017 
// Design Name:		
// Module Name:		auto_range 
// Project Name:	awake.bpm.firmware
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
  
  Automatically determines the VGA gain for the next measurement
  depending on the received and processed signals from the four channels
  
  Inputs:
  		
  		auto_enable - mode select bit for module: 1 -> enabled
  		ready - ready status bit for channel data: 1 -> ready to be read
  		[4:0] 	vga_in - 5 bit vga gain initial  
  		[15:0] 	signal_max_(a~d) - 16 bit signal amplitude calculated from <Max.v>
  	
  Outputs:
  		
  		[4:0] vga_out - 5 bit vga gain final
  
  Parameters:
   
   		threshold - upper amplitude threshold beyond which signals must be re-ranged
   		[2:0]	step - shifted steps for range adjustment in binary, intreperted as decimal in dB 
  
  See Also:
  
  		<Max.v>
 */
module auto_range(
	
	input auto_enable,
	input ready,
	input [4:0] vga_in,
	input [15:0] signal_max_a,
	input [15:0] signal_max_b,
	input [15:0] signal_max_c,
	input [15:0] signal_max_d,

	output reg [4:0] vga_out
	
    );
    
    parameter threshold = 20000;
    parameter [2:0] step = 3'b11;
    
    always @ (auto_enable) begin
    	if (ready) begin
    		
    		end
    	
    
    end    		
