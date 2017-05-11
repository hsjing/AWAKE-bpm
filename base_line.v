`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TRIUMF
// Engineer: Angela Zhou
// 
// Create Date:    23:12:20 03/03/2016 
// Design Name: 
// Module Name:    base_line 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// calculate the base_line when there is no event
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module base_line(
	input in_valid, //input data valid
	input [4*ADC_BIT-1:0] din,
	input clk,
	input rst,
	output reg out_valid,
	output reg [4*ADC_BIT-1:0] BL_data
);

parameter ADC_BIT = 16;
parameter state_idle = 0,
			 state_add = 1,
			 state_acc = 2,
			 state_div = 3,
			 state_wait = 4,
			 state_done = 5;
			 
reg [2:0] state;
reg [ADC_BIT-1:0] i;		 
reg [ADC_BIT-1:0] CNT;
reg [ADC_BIT-1:0] sumPrevA;
reg [ADC_BIT-1:0] addInA;
reg [ADC_BIT-1:0] divInA;
wire [ADC_BIT-1:0] sumA;
wire [ADC_BIT-1:0] divOutA;

reg [ADC_BIT-1:0] sumPrevB;
reg [ADC_BIT-1:0] addInB;
reg [ADC_BIT-1:0] divInB;
wire [ADC_BIT-1:0] sumB;
wire [ADC_BIT-1:0] divOutB;

reg [ADC_BIT-1:0] sumPrevC;
reg [ADC_BIT-1:0] addInC;
reg [ADC_BIT-1:0] divInC;
wire [ADC_BIT-1:0] sumC;
wire [ADC_BIT-1:0] divOutC;

reg [ADC_BIT-1:0] sumPrevD;
reg [ADC_BIT-1:0] addInD;
reg [ADC_BIT-1:0] divInD;
wire [ADC_BIT-1:0] sumD;
wire [ADC_BIT-1:0] divOutD;

wire rfdA;
wire [15:0] fractionalA;
wire rfdB;
wire [15:0] fractionalB;
wire rfdC;
wire [15:0] fractionalC;
wire rfdD;
wire [15:0] fractionalD;


always @(posedge clk)
begin
	if(rst)
	begin
		state <= state_idle;
		CNT <= 0;
		out_valid <= 0;
		i<=0;
	end
	
	else
	begin
		case(state)
			state_idle:
			begin
				if(in_valid)
					state <= state_add;
				else
					out_valid <= 0;
			end
			
			
			state_add:
			begin
				addInA[ADC_BIT-1:0] <= din[63:48];
				addInB[ADC_BIT-1:0] <= din[47:32];
				addInC[ADC_BIT-1:0] <= din[31:16];
				addInD[ADC_BIT-1:0] <= din[15:0];
				
				sumPrevA <= 0;
				sumPrevB <= 0;
				sumPrevC <= 0;
				sumPrevD <= 0;
				
				state <= state_acc;
				CNT <= CNT + 1;
			end
			
			state_acc:
				if(!in_valid)
				 begin
				  state <= state_wait;
				  divInA <= sumA;
				  divInB <= sumB;
				  divInC <= sumC;
				  divInD <= sumD;
				end
				
				else
				begin
					addInA[ADC_BIT-1:0] <= din[63:48];
					addInB[ADC_BIT-1:0] <= din[47:32];
					addInC[ADC_BIT-1:0] <= din[31:16];
					addInD[ADC_BIT-1:0] <= din[15:0];
					
					CNT <= CNT + 1;
					sumPrevA <= sumA;
					sumPrevB <= sumB;
					sumPrevC <= sumC;
					sumPrevD <= sumD;
				end
			
		/*	state_div:
			begin
				state <= state_wait;
			end
*/			
			state_wait: 
			begin
				if(i > 2*ADC_BIT+2)
					state <= state_done;
				else
					i <= i + 1;
			end
				
			state_done:
			begin
				out_valid <= 1;
				BL_data[63:48] <= divOutA;
				BL_data[47:32] <= divOutB;
				BL_data[31:16] <= divOutC;
				BL_data[15:0] <= divOutD;
				CNT <= 0; i<=0;
				state <= state_idle;
			end
				
		endcase
	end
end

ADD accA (
  .a(addInA), // input [15 : 0] a
  .b(sumPrevA), // input [15 : 0] b
  .s(sumA) // output [15 : 0] s
);
ADD accB (
  .a(addInB), // input [15 : 0] a
  .b(sumPrevB), // input [15 : 0] b
  .s(sumB) // output [15 : 0] s
);
ADD accC (
  .a(addInC), // input [15 : 0] a
  .b(sumPrevC), // input [15 : 0] b
  .s(sumC) // output [15 : 0] s
);
ADD accD (
  .a(addInD), // input [15 : 0] a
  .b(sumPrevD), // input [15 : 0] b
  .s(sumD) // output [15 : 0] s
);
DIV divideA (
	.clk(clk), // input clk
	.sclr(rst), // input sclr
	.rfd(rdfA), // ouput rfd
	.dividend(divInA), // input [15 : 0] dividend
	.divisor(CNT), // input [15 : 0] divisor
	.quotient(divOutA), // ouput [15 : 0] quotient
	.fractional(fractionalA)); // ouput [15 : 0] fractional
DIV divideB (
	.clk(clk), // input clk
	.sclr(rst), // input sclr
	.rfd(rfdB), // ouput rfd
	.dividend(divInB), // input [15 : 0] dividend
	.divisor(CNT), // input [15 : 0] divisor
	.quotient(divOutB), // ouput [15 : 0] quotient
	.fractional(fractionalB)); // ouput [15 : 0] fractional
DIV divideC (
	.clk(clk), // input clk
	.sclr(rst), // input sclr
	.rfd(rfdC), // ouput rfd
	.dividend(divInC), // input [15 : 0] dividend
	.divisor(CNT), // input [15 : 0] divisor
	.quotient(divOutC), // ouput [15 : 0] quotient
	.fractional(fractionalC)); // ouput [15 : 0] fractional
DIV divideD (
	.clk(clk), // input clk
	.sclr(rst), // input sclr
	.rfd(rfdD), // ouput rfd
	.dividend(divInD), // input [15 : 0] dividend
	.divisor(CNT), // input [15 : 0] divisor
	.quotient(divOutD), // ouput [15 : 0] quotient
	.fractional(fractionalD)); // ouput [15 : 0] fractional

endmodule
