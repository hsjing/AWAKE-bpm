`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TRIUMF	
// Engineer: Angela Zhou
// 
// Create Date:    14:31 03/22/2016 
// Design Name: 
// Module Name:    position 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//	calculate X,Y position based on equation X = (D/4)*1000*(A-B)/(A+B), output a rdy signal to indicate the calculation is completed 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module position(
	input clk,
	input rst,
	input data_valid,
	input [31:0] A_IN,
	input [31:0] B_IN,
	input [31:0] C_IN,
	input [31:0] D_IN,
	input [15:0] Diameter,
	output reg [31:0] X,
	output reg [31:0] Y,
	output reg [31:0] S,
	output reg rdy
    );
parameter float_4 = 32'h40800000;
parameter float_1000 = 32'h447a0000;

reg [4:0] CNT;
reg [4:0] state;

reg [31:0] ABsub;
reg [31:0] ABadd;
reg [31:0] D_4;
reg [31:0] CDadd;
reg [31:0] ABdiv;
reg [31:0] X_temp;
reg [31:0] CDsub;
reg [31:0] X_float;
reg [31:0] CDdiv;
reg [31:0] S_float;
reg [31:0] Y_temp;
reg [31:0] Y_float;



parameter state_idle = 0,
			 state_abAdd = 1,
			 state_cdAdd = 2,
			 state_cdSub = 3,
			 state_cdDiv = 4,
			 state_cdMul = 5,
			 state_cdMul2 = 6,
			 state_cdConvrt = 7,
			 state_sConvert = 8,
			 state_done = 9,
			 state_wait1 = 10,
			 state_S = 11,
			 state_wait2 = 12,
			 state_wait3 = 13,
			 state_wait4 = 14,
			 state_wait5 = 15;
		
			 
always @(posedge clk)
begin
	if(rst)
		begin
			X <= 0;
			Y <= 0;
			S <= 0;
			state <= state_idle;
			rdy <= 0;
		end
	
	else
		begin
			case(state)
				state_idle:
					begin
						rdy <= 0;
						if(data_valid)		//if data_valid, SubAdd_inst first operate A-B, also convert Diameter(fix) to float
							begin
								input1 <= A_IN;
								input2 <= B_IN;
								op <= sub;
								dia_fix <= Diameter;
								state <= state_abAdd;

							end
					end
						


					
				state_abAdd:		//store result from SubAdd_inst into ABsub reg, change op to add to operate A+B, also use div_inst to operate D/4
					begin
						ABsub <= result1;
						op <= add;
						input3 <= dia_float;
						input4 <= float_4;
						state <= state_cdAdd;	

					end
				

				state_cdAdd:		//store D/4 result in D_4 reg, SubAdd_inst result in ABadd, also use SubAdd_inst to operate C+D
					begin
						D_4 <= result2;
						ABadd <= result1;
						input1 <= C_IN;
						input2 <= D_IN;
						state <= state_wait1;	

					end
				
				state_wait1:		//store SubAdd_inst result in CDadd reg, also use div_inst to operate (A-B)/(A+B)
					begin
						CDadd <= result1;
						input3 <= ABsub;
						input4 <= ABadd;
						state <= state_S;
					end
				
				state_S:		//use SubAdd_inst to operate A+B+C+D,also store dib_inst result in ABdiv
					begin
						input1 <= CDadd;
						input2 <= ABadd;
						ABdiv <= result2;
						state <= state_cdSub;
					
					end
					
				state_cdSub:
					begin
						S_float <= result1;		//store A+B+C+D in S_float reg, change op to sub to operate C-D, also use mul_inst to operate (A-B)/(A+B)*(D/4)
						op <= sub;
						input1 <= C_IN;
						input2 <= D_IN;
						input5 <= ABdiv;
						input6 <= D_4;
						state <= state_wait2;
					end
					
				state_wait2:		//store the mul_inst result in X_temp reg, and store C-D in CDsub reg
					begin
						X_temp <= result3;
						CDsub <= result1;
						state <= state_cdDiv;
					end

					
				state_cdDiv:	//operate (C-D)/(C+D) and X_temp*1000
					begin

						input3 <= CDsub;
						input4 <= CDadd;
						input5 <= X_temp;
						input6 <= float_1000;
						state <= state_wait3;

					end
				state_wait3:		//store X_temp*1000 in X_float reg, store (C-D)/(C+D) in CDdiv
					begin
						X_float <= result3;
						CDdiv <= result2;
						state <= state_cdMul;
					end
					
				state_cdMul:		//operate CDdiv * (D/4), convert X_float to X(fix)
					begin

						input5 <= CDdiv;
						input6 <= D_4;
						input7 <= X_float;
						state <= state_wait4;

					end
				state_wait4:		//store X(fix) to output reg X, store CDdiv * (D/4) in Y_temp
					begin
						X <= result4;
						Y_temp <= result3;
						state <= state_cdMul2;
					end
					
				state_cdMul2:		//operate Y_temp * 1000, convert S_float to S(fix)
					begin

						input5 <= Y_temp;
						input6 <= float_1000;
						input7 <= S_float;
						state <= state_wait5;

					end
				state_wait5:	//store S(fix) to output reg S, store Y_temp * 1000 in Y_float reg
					begin
					S <= result4;
					Y_float <= result3;
					state <= state_cdConvrt;
					end

			state_cdConvrt:	//convert Y_float to Y(fix)
				begin

					input7 <= Y_float;
					state <= state_done;

				end
			
			state_done:		//store Y(fix) to output reg Y, rdy goes high
				begin
					Y <= result4;
					rdy <= 1;
					state <= state_idle;
				end
				
			default: 
				begin
					state <= state_idle;
				end
		endcase
	end
end
				


wire [5:0] sub = 6'b000001;
wire [5:0] add = 6'b0;		
wire nd = 1;	
wire [31:0] result1;	
wire rdy_SubAdd;	

reg [31:0] input1;
reg [31:0] input2;
reg [5:0] op;
						
SUB_ADD sub_add_inst (
  .a(input1), // input [31 : 0] a
  .b(input2), // input [31 : 0] b
  .operation(op), // input [5 : 0] operation
  .result(result1), // output [31 : 0] result
  .rdy(rdy_SubAdd) // output rdy
);
reg [15:0] dia_fix;
wire [31:0] dia_float;
wire rdy_Fix2Float;

fix_float Dia_float_inst (
  .a(dia_fix), // input [15 : 0] a
  .operation_nd(nd), // input operation_nd
  .operation_rfd(), // output operation_rfd
  .result(dia_float), // output [31 : 0] result
  .rdy(rdy_Fix2Float) // output rdy
);

reg [31:0] input3;
reg [31:0] input4;

wire [31:0] result2;
wire rdy_div;

DIVD divide_inst (
  .a(input3), // input [31 : 0] a
  .b(input4), // input [31 : 0] b
  .operation_nd(nd), // input operation_nd
  .operation_rfd(), // output operation_rfd
  .result(result2), // output [31 : 0] result
  .underflow(underflow), // output underflow
  .overflow(overflow), // output overflow
  .invalid_op(invalid_op), // output invalid_op
  .divide_by_zero(divide_by_zero), // output divide_by_zero
  .rdy(rdy_div) // output rdy
);
reg [31:0] input5;
reg [31:0] input6;

wire [31:0] result3;
wire rdy_mul;


MUL multiple_inst (
  .a(input5), // input [31 : 0] a
  .b(input6), // input [31 : 0] b
  .operation_nd(nd), // input operation_nd
  .operation_rfd(), // output operation_rfd
  .result(result3), // output [31 : 0] result
  .underflow(), // output underflow
  .overflow(), // output overflow
  .invalid_op(), // output invalid_op
  .rdy(rdy_mul) // output rdy
);

reg [31:0] input7;

wire [31:0] result4;
wire rdy_Float2Fix;

float_fix float_fix_inst (
  .a(input7), // input [31 : 0] a
  .operation_nd(nd), // input operation_nd
  .operation_rfd(), // output operation_rfd
  .result(result4), // output [31 : 0] result
  .overflow(), // output overflow
  .invalid_op(), // output invalid_op
  .rdy(rdy_Float2Fix) // output rdy
);
endmodule