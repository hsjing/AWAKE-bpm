`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		TRIUMF
// Engineer:		Jing Huang
// 
// Create Date:		14:05:22 05/24/2017 
// Design Name:		
// Module Name:		skew_adjust 
// Project Name:		awake.bpm.firmware
// Target Devices:	SPARTAN 6 LX150T
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
	Module: skew_adjust

		Automatically compensates for the skew in input signal due to electrode installation and wiring
		As of now, only two channels are compensated: A and C. 
  
	Inputs:
  		
  		Cal_ST - static calibration flag
  		Cal_OL - online calibration flag
  		Cal_FLAG - calibration event flag, apply skew adjust  		
  		clk - process to be clocked from PLL, as determined by PLL  		
  		rst - reset flag
  		data_valid - ready status bit of valid data, 1 -> valid data
  		
  		ChA_skew - input skew adjust factor for channel A
		ChC_skew - input skew adjust factor for Channel C

		chA_power - input power from A for adjustment
		chC_power - input power from C for adjustment 
  	
	Outputs:
  		
  		chA_skew_adj - adjusted power for A
  		chC_skew_adj - adjusted power for C
  		
  		skew_rdy - flag for completed skew adjustment
  		
  
	Parameters:

		SF_WIDTH - register width for data bus
		"States" - the various states of the state-machine

	Registers:

		chA_skew_temp - temporary storage for skew-compensated channel A power
		chC_skew_temp - temporary storage for skew-compensated channel C power
		nd - new data ready flag
		MulA - first multiple for multiplier
		MulB - second multiple for multiplier
		state - current state of the state machine
	
	Wires:
	
		MulOut - product of multiplication
		mul_rdy - multiplier ready for readout
		mul_rfd - multiplier ready for input

	See Also:
  
  		<Gain_Adjust.v>
		
	TODO:

		- Add register access from UI using method from notes.txt
		- Test the module
 */
 
module skew_adjust(
	
	input Cal_ST,
	input Cal_OL,
	input Cal_FLAG,
	input clk,
	input rst,
	input data_valid,
	
	input [SF_WIDTH-1:0] chA_skew,
	input [SF_WIDTH-1:0] chC_skew,
	
	input [SF_WIDTH-1:0] chA_power,
	input [SF_WIDTH-1:0] chC_power,
	
	output reg [SF_WIDTH-1:0] chA_skew_adj,
	output reg [SF_WIDTH-1:0] chC_skew_adj,
	
	output reg skew_rdy	
		
	);
	
	parameter DATA_WIDTH = 16;
	parameter SF_WIDTH = 32;
	
	/* State machine states */
	parameter idle = 0,
			A_GAIN = 1, A_GAIN_WAIT = 2,			
			C_GAIN = 3, C_GAIN_WAIT = 4,			
			done = 5;
	
	reg [SF_WIDTH-1:0] chA_skew_temp;
	reg [SF_WIDTH-1:0] chC_skew_temp;

	reg nd;	
	reg [SF_WIDTH-1:0] MulA;
	reg [SF_WIDTH-1:0] MulB;	
	reg [4:0] state;

	wire [31:0] MulOut;
	wire mul_rdy;
	wire mul_rfd;
	
	/* Beginning of state machine */
	always @ (posedge clk) begin
	
		/* If reset, zero stored power values and set state to idle */
		if(rst) begin
			state <= idle;
			chA_skew_adj <= 0;
			chC_skew_adj <= 0;
			skew_rdy <= 0;
			nd <= 0;
			end
		
		/* Else begin state machine */
		else begin
			case (state)
				idle:
				begin
					skew_rdy <= 0;
					nd <= 0;
					if(data_valid) state <= A_GAIN;
					end
				
				A_GAIN:
				if(mul_rfd) begin
					MulA <= chA_power;
					if (Cal_ST || Cal_OL || Cal_FLAG) MulB <= 1; ///< If any calibration flags are on, set skew factor to 1
					else MulB <= chA_skew; ///< Else use user defined skew factor
					state <= A_GAIN_WAIT;
					nd <= 1;
					end
					
				A_GAIN_WAIT:
				begin
					nd <= 0;
					if(mul_rdy) begin
						chA_skew_adj <= MulOut; ///< Store product as adjusted power value
						state <= C_GAIN;
						end
					end
				
				C_GAIN:
				if(mul_rfd) begin
					MulA <= chC_power;
					if (Cal_ST || Cal_OL || Cal_FLAG) MulB <= 1; ///< If any calibration flags are on, set skew factor to 1
					else MulB <= chC_skew; ///< Else use user defined skew factor
					state <= C_GAIN_WAIT;
					nd <= 1;
					end
				
				C_GAIN_WAIT:
				begin
					nd <= 0;
					if(mul_rdy) begin
						chC_skew_adj <= MulOut; // Store product as adjusted power value
						state <= done;
						end
					end
				
				/* State machine completes */
				done:
				begin
					skew_rdy <= 1;
					nd <= 0;
					state <= idle;
					end	
				endcase
			end
		end

	/* Load in multiplier */
	float_square float_mul (
		.a(MulA),
		.b(MulB),
		.operation_nd(nd),
		.operation_rfd(mul_rfd),
		.result(MulOut),
		.underflow(),
		.overflow(),
		.invalid_op(),
		.rdy(mul_rdy)
	);

endmodule    		
