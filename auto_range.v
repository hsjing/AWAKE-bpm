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
  
  Automatically determines the VGA attenuation for the next measurement
  depending on the received and processed signals from the four channels
  
  Inputs:
  		
  		clk - process to be clocked from PLL, as determined by PLL
  		auto_enable - mode select bit for module: 1 -> enabled
  		ready - ready status bit for channel data: 1 -> ready to be read
  		[4:0] 	vga_in - 5 bit vga attenuation initial  
  		[15:0] 	signal_max_(a~d) - 16 bit signal amplitude calculated from <Max.v>
  	
  Outputs:
  		
  		[4:0] vga_out - 5 bit vga attenuation final
  
  Parameters:
   
   		upper_threshold - upper amplitude threshold beyond which signals must be re-ranged
   		lower_threshold - lower amplitude threshold that justifies increasing VGA attenuation
   		data_width - bit size of incoming amplitude data
   		step - attenuation shift in dB   		
   
  Registers:

   		[2:0]	step - shifted steps for range adjustment in binary, intreperted as decimal in dB
   		[data_width-1:0]	signal_max_all - storage register for overall maximum amplitude after program iteration
  
  See Also:
  
  		<Max.v>
 */
 
module auto_range(
	input clk,
	input auto_enable,
	input ready,
	input [4:0] vga_in,
	input [15:0] signal_max_a,
	input [15:0] signal_max_b,
	input [15:0] signal_max_c,
	input [15:0] signal_max_d,

	output reg [4:0] vga_out	
    );    
    
    parameter upper_threshold = 20000;	// Full range of amplitude is 32768
    parameter lower_threshold = 14000;	// Lower threshold roughly 3 dB less than upper threshold     
    parameter data_width = 16;
    parameter step = 3;
    
    reg [data_width-1:0] signal_max_all;
    
    always @ (posedge clk) begin
    	if(auto_enable && ready) begin        	
			/* Comparatively loads the maximum signal from all channels */
			if (signal_max_a[15:0] > signal_max_all)	signal_max_all <= signal_max_a;
			if (signal_max_b[15:0] > signal_max_all)	signal_max_all <= signal_max_b;
			if (signal_max_c[15:0] > signal_max_all)	signal_max_all <= signal_max_c;
			if (signal_max_d[15:0] > signal_max_all)	signal_max_all <= signal_max_d;
				
			/* Lower or increase VGA attenuation depending on signal_max_all relative to the corresponding thresholds */
			if (vga_in >= step) begin 
				if (signal_max_all > upper_threshold)	vga_out <= vga_in + step;
				if (signal_max_all < lower_threshold)	vga_out <= vga_in - step;
				end					    	    
    		end
    	end    	
endmodule    		
