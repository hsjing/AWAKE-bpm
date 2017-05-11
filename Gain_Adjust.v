`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:36:34 04/21/2016 
// Design Name: 
// Module Name:    Gain_Adjust 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Revision 0.02 - 2017/Feb/10, Andy, Added gain and cal_gain for channel B and D, 
// Additional Comments: 

//////////////////////////////////////////////////////////////////////////////////
module Gain_Adjust(
	input Cal_ST, //in Static Cal_mode, the Cal_gain will be applied to signals
   input Cal_OL, //in Online cal mode, the Ch_gain and Drift_gain will be applifed to true event signals	
	input Cal_FLAG, //mark the cal event, cal_gain and drift_gain will be applified 
	input [SF_WIDTH-1:0] ChA_Gain,
	input [SF_WIDTH-1:0] ChB_Gain,
	input [SF_WIDTH-1:0] ChC_Gain,
	input [SF_WIDTH-1:0] ChD_Gain,
	input [SF_WIDTH-1:0] ChA_Cal_Gain,
	input [SF_WIDTH-1:0] ChB_Cal_Gain,
	input [SF_WIDTH-1:0] ChC_Cal_Gain,
	input [SF_WIDTH-1:0] ChD_Cal_Gain,
	input [SF_WIDTH-1:0] ChA_Drift_Gain,
	input [SF_WIDTH-1:0] ChB_Drift_Gain,
	input [SF_WIDTH-1:0] ChC_Drift_Gain,
	input [SF_WIDTH-1:0] ChD_Drift_Gain,
	input [SF_WIDTH-1:0] ChA_Power,
	input [SF_WIDTH-1:0] ChB_Power,
	input [SF_WIDTH-1:0] ChC_Power,
	input [SF_WIDTH-1:0] ChD_Power,
	input clk,
	input rst,
	input datain_valid,
	
	output reg [SF_WIDTH-1:0] ChA_Power_Adj,
	output reg [SF_WIDTH-1:0] ChB_Power_Adj,
	output reg [SF_WIDTH-1:0] ChC_Power_Adj,
	output reg [SF_WIDTH-1:0] ChD_Power_Adj,
	output reg Adj_rdy
	
    );

parameter  	DATA_WIDTH = 16;
parameter  	SF_WIDTH = 32;

parameter idle = 0,
			 A_GAIN = 1, A_GAIN_WAIT = 2,
			 B_GAIN = 3, B_GAIN_WAIT = 4,
			 C_GAIN = 5, C_GAIN_WAIT = 6,
			 D_GAIN = 7, D_GAIN_WAIT = 8,
			 A_Cor = 9, A_Cor_WAIT = 10,
			 B_Cor = 11, B_Cor_WAIT = 12,
			 C_Cor = 13, C_Cor_WAIT = 14,
			 D_Cor = 15, D_Cor_WAIT = 16,
			 power_ST = 17, done = 18;
			 
reg [SF_WIDTH-1:0] ChA_Power_temp;
reg [SF_WIDTH-1:0] ChB_Power_temp;
reg [SF_WIDTH-1:0] ChC_Power_temp;
reg [SF_WIDTH-1:0] ChD_Power_temp;

reg nd;
wire mul_rdy;
wire mul_rfd; //Muliplyer ready for data 
reg [31:0] MulA;
reg [31:0] MulB;
wire [31:0] MulOut;

reg [4:0] state;

always @(posedge clk)
begin
	if(rst)
		begin
		   state <= idle;
			ChA_Power_Adj <= 0;
			ChB_Power_Adj <= 0;
			ChC_Power_Adj <= 0;
			ChD_Power_Adj <= 0;
			Adj_rdy <= 0;
			nd <= 0;
		end
	
	else 
		begin
			case(state)
			idle:
					begin
						Adj_rdy <= 0;
						nd <= 0;
						if(datain_valid)  state <= A_GAIN; 
					end					
			A_GAIN:				
				   if (mul_rfd) 
					  begin MulA <= ChA_Power; 
					        if (Cal_ST) MulB <= ChA_Cal_Gain;
							  else if (Cal_FLAG ) MulB <= ChA_Cal_Gain;
							  else MulB <= ChA_Gain; 
							  nd <= 1; 
							  state <= A_GAIN_WAIT; 
					  end							
			A_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChA_Power_temp <= MulOut;
						state <= B_GAIN;
					 end
				end

			B_GAIN:				
				   if (mul_rfd) 
					  begin MulA <= ChB_Power; 
					        if (Cal_ST ) MulB <= ChB_Cal_Gain;
							  else if (Cal_FLAG ) MulB <= ChB_Cal_Gain;
							  else MulB <= ChB_Gain; 
							  nd <= 1; 
							  state <= B_GAIN_WAIT; 
					  end							
			B_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChB_Power_temp <= MulOut;
						state <= C_GAIN;
					 end
				end

			C_GAIN:				
				   if (mul_rfd) 
					  begin MulA <= ChC_Power; 
					        if (Cal_ST ) MulB <= ChC_Cal_Gain;
							  else if (Cal_FLAG ) MulB <= ChC_Cal_Gain;
							       else MulB <= ChC_Gain; 
							  nd <= 1; 
							  state <= C_GAIN_WAIT; 
					  end														
			C_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChC_Power_temp <= MulOut;
						state <= D_GAIN;
					 end
				end

			D_GAIN:				
				   if (mul_rfd) 
					  begin MulA <= ChD_Power; 
					        if (Cal_ST ) MulB <= ChD_Cal_Gain;
							  else if (Cal_FLAG ) MulB <= ChD_Cal_Gain;
							       else MulB <= ChD_Gain; 
							  nd <= 1; 
							  state <= D_GAIN_WAIT; 
					  end														
			D_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChD_Power_temp <= MulOut;
						if (Cal_OL && ~Cal_FLAG) state <= A_Cor;
						else state <= power_ST;
						//state <= power_ST;
					 end
				end				
				
	      A_Cor: //Online Gain Correction for Channel A,B,C,D
			   if (mul_rfd) 
					  begin MulA <= ChA_Power_temp; 
					        MulB <= ChA_Drift_Gain;
							  nd <= 1; 
							  state <= A_Cor_WAIT; 
					  end							
			A_Cor_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChA_Power_Adj <= MulOut;
						state <= B_Cor;
					 end
				end

	      B_Cor: 
			   if (mul_rfd) 
					  begin MulA <= ChB_Power_temp; 
					        MulB <= ChB_Drift_Gain;
							  nd <= 1; 
							  state <= B_Cor_WAIT; 
					  end							
			B_Cor_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChB_Power_Adj <= MulOut;
						state <= C_Cor;
					 end
				end
		  
	      C_Cor: 
			   if (mul_rfd) 
					  begin MulA <= ChC_Power_temp; 
					        MulB <= ChC_Drift_Gain;
							  nd <= 1; 
							  state <= C_Cor_WAIT; 
					  end							
			C_Cor_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChC_Power_Adj <= MulOut;
						state <= D_Cor;
					 end
				end

	      D_Cor: 
			   if (mul_rfd) 
					  begin MulA <= ChD_Power_temp; 
					        MulB <= ChD_Drift_Gain;
							  nd <= 1; 
							  state <= D_Cor_WAIT; 
					  end							
			D_Cor_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChD_Power_Adj <= MulOut;
						state <= done;
					 end
				end
				
			power_ST:
				begin
				   ChA_Power_Adj <= ChA_Power_temp;
					ChB_Power_Adj <= ChB_Power_temp;
					ChC_Power_Adj <= ChC_Power_temp;
					ChD_Power_Adj <= ChD_Power_temp;
					state <= done;
				end
			
			done:
				begin
					Adj_rdy <= 1;
					nd <= 0;
					state <= idle;
				end
			
			default:	state <= idle;
			
		endcase 
	end
	
end


float_square float_mul (		//square all the floating number
  .a(MulA), // input [31 : 0] a
  .b(MulB), // input [31 : 0] b
  .operation_nd(nd), // input operation_nd
  .operation_rfd(mul_rfd), // output operation_rfd
  .result(MulOut), // output [31 : 0] result
  .underflow(), // output underflow
  .overflow(), // output overflow
  .invalid_op(), // output invalid_op
  .rdy(mul_rdy) // output rdy
);


endmodule
