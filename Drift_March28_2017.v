`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shengli Liu
// 
// Create Date:    15:19:30 03/22/2017 
// Design Name: 
// Module Name:    Drift 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Calculate ChX_Drift_Gain = ChX_Cal_Gain*VGA_Gain*1625/X_power_cal,
// to be multiplied to Ch_Gain, to compensate gain drift.
// 1625 is chosen to make ChX_Drift_Gain to be close to 1. This number is correct for the
// 404MHz cal signal has a 20dB attenuator.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Drift(
 //  inout [35:0] ila_CONTROL0,
//	inout [35:0] ila_CONTROL1,
	
	input [SF_WIDTH-1:0] K_cal,
	input [4:0] VGA_gain,
	
	input [SF_WIDTH-1:0] ChA_Cal_Gain,
	input [SF_WIDTH-1:0] ChB_Cal_Gain,
	input [SF_WIDTH-1:0] ChC_Cal_Gain,
	input [SF_WIDTH-1:0] ChD_Cal_Gain,
	
	input [SF_WIDTH-1:0] A_Cal,
	input [SF_WIDTH-1:0] B_Cal,
	input [SF_WIDTH-1:0] C_Cal,
	input [SF_WIDTH-1:0] D_Cal,
	
	input clk,
	input rst,
	input data_valid,
	
	output reg [SF_WIDTH-1:0] ChA_Gain_Corr,
	output reg [SF_WIDTH-1:0] ChB_Gain_Corr,
	output reg [SF_WIDTH-1:0] ChC_Gain_Corr,
	output reg [SF_WIDTH-1:0] ChD_Gain_Corr,
	output reg Corr_rdy
    );

parameter  	DATA_WIDTH = 16;
parameter  	SF_WIDTH = 32;

parameter  	dB0 = 32'h3F800000; //SF IEEE754 format of dB gain
parameter  	dB1 = 32'h3f8f9db2; 
parameter  	dB2 = 32'h3fa123a3;
parameter  	dB3 = 32'h3fb4cccd;
parameter  	dB4 = 32'h3fcade01;
parameter  	dB5 = 32'h3fe39f56;
parameter  	dB6 = 32'h3fff65fe;
parameter  	dB7 = 32'h400f46dc;
parameter  	dB8 = 32'h4020c2f8;
parameter  	dB9 = 32'h403460aa;
parameter  	dB10 = 32'h404a6320;
parameter  	dB11 = 32'h40631412;
parameter  	dB12 = 32'h407eca58;
parameter  	dB13 = 32'h408ef007;
parameter  	dB14 = 32'h40a0617c;
parameter  	dB15 = 32'h40b3f2e5;
parameter  	dB16 = 32'h40c9e83e;
parameter  	dB17 = 32'h40e28b44;
parameter  	dB18 = 32'h40fe2f83;
parameter  	dB19 = 32'h410e999a;
parameter  	dB20 = 32'h41200000;
parameter  	dB21 = 32'h413385f0;
parameter  	dB22 = 32'h41496dc6;
parameter  	dB23 = 32'h416201a3;
parameter  	dB24 = 32'h417d9518;
parameter  	dB25 = 32'h418e432d;
parameter  	dB26 = 32'h419f9eed;
parameter  	dB27 = 32'h41b318fc;
parameter  	dB28 = 32'h41c8f382;
parameter  	dB29 = 32'h41e1786c;
parameter  	dB30 = 32'h41fcfb7f;
parameter  	dB31 = 32'h420decda;

parameter idle = 0,
			 A_GAIN = 1, A_GAIN_WAIT = 2,
			 B_GAIN = 3, B_GAIN_WAIT = 4,
			 C_GAIN = 5, C_GAIN_WAIT = 6,
			 D_GAIN = 7, D_GAIN_WAIT = 8, 
			 A_Kcal = 9, A_Kcal_WAIT = 10,
			 B_Kcal = 11, B_Kcal_WAIT = 12,
			 C_Kcal = 13, C_Kcal_WAIT = 14,
			 D_Kcal = 15, D_Kcal_WAIT = 16, 
			 A_Div = 17, A_Div_WAIT = 18,
			 B_Div = 19, B_Div_WAIT = 20,
			 C_Div = 21, C_Div_WAIT = 22,
			 D_Div = 23, D_Div_WAIT = 24, 
			 done = 25;
			 
reg nd,nd1; //new data command to multiplier
wire mul_rdy, mul_rdy1; //Multiplier output data is ready. 
wire mul_rfd, mul_rfd1; //Multiplier ready for data
reg [31:0] MulA,MulA1;
wire [31:0] MulOut,MulOut1;

reg div_nd;
wire div_rfd;
reg [SF_WIDTH-1:0] Denom, Nom;
wire [SF_WIDTH-1:0] div_out;

reg [4:0] state;
reg [SF_WIDTH-1:0] ChA_Power_Adj;
reg [SF_WIDTH-1:0] ChB_Power_Adj;
reg [SF_WIDTH-1:0] ChC_Power_Adj;
reg [SF_WIDTH-1:0] ChD_Power_Adj;

reg [SF_WIDTH-1:0] ChA_Power_Adj1;
reg [SF_WIDTH-1:0] ChB_Power_Adj1;
reg [SF_WIDTH-1:0] ChC_Power_Adj1;
reg [SF_WIDTH-1:0] ChD_Power_Adj1;

always @(posedge clk)
begin
	if(rst)
		begin
			state <= idle;
			ChA_Gain_Corr <= 0;
			ChB_Gain_Corr <= 0;
			ChC_Gain_Corr <= 0;
			ChD_Gain_Corr <= 0;
			Corr_rdy <= 0;
			nd <= 0;
			nd1 <= 0;
			div_nd <= 0;
		end
	else 
		begin
			case(state)
			idle:
					begin
						Corr_rdy <= 0;
						nd <= 0;
						if(data_valid)  state <= A_GAIN; 
					end					
			A_GAIN:			
				   if (mul_rfd) 
					  begin MulA <= ChA_Cal_Gain; 
							  nd <= 1; 
							  state <= A_GAIN_WAIT; 
					  end							
			A_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChA_Power_Adj <= MulOut;
						state <= B_GAIN;
					 end
				end

			B_GAIN:				
				   if (mul_rfd) 
					  begin MulA <= ChB_Cal_Gain; 
					        nd <= 1; 
							  state <= B_GAIN_WAIT; 
					  end							
			B_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChB_Power_Adj <= MulOut;
						state <= C_GAIN;
					 end
				end

			C_GAIN:				
				   if (mul_rfd) 
					  begin MulA <= ChC_Cal_Gain; 
					        nd <= 1; 
							  state <= C_GAIN_WAIT; 
					  end														
			C_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChC_Power_Adj <= MulOut;
						state <= D_GAIN;
					 end
				end

			D_GAIN:				
				   if (mul_rfd) 
					  begin MulA <= ChD_Cal_Gain; 
					        nd <= 1; 
							  state <= D_GAIN_WAIT; 
					  end														
			D_GAIN_WAIT:
			   begin
				  nd <= 0;
			     if(mul_rdy)
					 begin
						ChD_Power_Adj <= MulOut;
						state <= A_Kcal;
					 end
				end				
		   A_Kcal: 
				if (mul_rfd1) 
					  begin MulA1 <= ChA_Power_Adj; 
							  nd1 <= 1; 
							  state <= A_Kcal_WAIT; 
					  end	
			A_Kcal_WAIT:
			   begin
				  nd1 <= 0;
			     if(mul_rdy1)
					 begin
						ChA_Power_Adj1 <= MulOut1;
						state <= B_Kcal;
					 end
				end
			B_Kcal: 
				if (mul_rfd1) 
					  begin MulA1 <= ChB_Power_Adj; 
							  nd1 <= 1; 
							  state <= B_Kcal_WAIT; 
					  end	
			B_Kcal_WAIT:
			   begin
				  nd1 <= 0;
			     if(mul_rdy1)
					 begin
						ChB_Power_Adj1 <= MulOut1;
						state <= C_Kcal;
					 end
				end
			C_Kcal: 
				if (mul_rfd1) 
					  begin MulA1 <= ChC_Power_Adj; 
							  nd1 <= 1; 
							  state <= C_Kcal_WAIT; 
					  end	
			C_Kcal_WAIT:
			   begin
				  nd1 <= 0;
			     if(mul_rdy1)
					 begin
						ChC_Power_Adj1 <= MulOut1;
						state <= D_Kcal;
					 end
				end
			D_Kcal: 
				if (mul_rfd1) 
					  begin MulA1 <= ChD_Power_Adj; 
							  nd1 <= 1; 
							  state <= D_Kcal_WAIT; 
					  end	
			D_Kcal_WAIT:
			   begin
				  nd1 <= 0;
			     if(mul_rdy1)
					 begin
						ChD_Power_Adj1 <= MulOut1;
						state <= A_Div;
					 end
				end
			A_Div: 
				if (div_rfd) 
					  begin Nom <= ChA_Power_Adj1; 
							  Denom <= A_Cal;
							  div_nd <= 1; 
							  state <= A_Div_WAIT; 
					  end	
			A_Div_WAIT:
			   begin
				  div_nd <= 0;
			     if(div_rdy)
					 begin
						ChA_Gain_Corr <= div_out;
						state <= B_Div;
					 end
				end	
			B_Div: 
				if (div_rfd) 
					  begin Nom <= ChB_Power_Adj1; 
							  Denom <= B_Cal;
							  div_nd <= 1; 
							  state <= B_Div_WAIT; 
					  end	
			B_Div_WAIT:
			   begin
				  div_nd <= 0;
			     if(div_rdy)
					 begin
						ChB_Gain_Corr <= div_out;
						state <= C_Div;
					 end
				end	
			C_Div: 
				if (div_rfd) 
					  begin Nom <= ChC_Power_Adj1; 
							  Denom <= C_Cal;
							  div_nd <= 1; 
							  state <= C_Div_WAIT; 
					  end	
			C_Div_WAIT:
			   begin
				  div_nd <= 0;
			     if(div_rdy)
					 begin
						ChC_Gain_Corr <= div_out;
						state <= D_Div;
					 end
				end	
			D_Div: 
				if (div_rfd) 
					  begin Nom <= ChD_Power_Adj1; 
							  Denom <= D_Cal;
							  div_nd <= 1; 
							  state <= D_Div_WAIT; 
					  end	
			D_Div_WAIT:
			   begin
				  div_nd <= 0;
			     if(div_rdy)
					 begin
						ChD_Gain_Corr <= div_out;
						state <= done;
					 end
				end	
				
			done:
				begin
					Corr_rdy <= 1;
					state <= idle;
				end
			
			default:	state <= idle;
			
		endcase 
	end
	
end

wire [SF_WIDTH-1:0] VGA = VGA_gain == 0? dB0 
				 :VGA_gain == 1? dB1
				 :VGA_gain == 2? dB2
				 :VGA_gain == 3? dB3
				 :VGA_gain == 4? dB4
				 :VGA_gain == 5? dB5
				 :VGA_gain == 6? dB6
				 :VGA_gain == 7? dB7
				 :VGA_gain == 8? dB8
				 :VGA_gain == 9? dB9
				 :VGA_gain == 10? dB10
				 :VGA_gain == 11? dB11
				 :VGA_gain == 12? dB12
				 :VGA_gain == 13? dB13
				 :VGA_gain == 14? dB14
				 :VGA_gain == 15? dB15
				 :VGA_gain == 16? dB16
				 :VGA_gain == 17? dB17
				 :VGA_gain == 18? dB18
				 :VGA_gain == 19? dB19				 
             :VGA_gain == 20? dB20
				 :VGA_gain == 21? dB21
				 :VGA_gain == 22? dB22
				 :VGA_gain == 23? dB23
				 :VGA_gain == 24? dB24
				 :VGA_gain == 25? dB25
				 :VGA_gain == 26? dB26
				 :VGA_gain == 27? dB27
				 :VGA_gain == 28? dB28
				 :VGA_gain == 29? dB29
				 :VGA_gain == 30? dB30
				 :VGA_gain == 31? dB31
				 :dB0;
				 
float_square float_mul1 (		//square all the floating number
  .a(MulA), // input [31 : 0] a
  .b(VGA), // input [31 : 0] b
  .operation_nd(nd), // input operation_nd
  .operation_rfd(mul_rfd), // output operation_rfd
  .result(MulOut), // output [31 : 0] result
  .underflow(), // output underflow
  .overflow(), // output overflow
  .invalid_op(), // output invalid_op
  .rdy(mul_rdy) // output rdy
);

//wire [SF_WIDTH-1:0] K_cal = 32'h44cb2000; // decimal 1625

float_square float_mul2 (		//square all the floating number
  .a(MulA1), // input [31 : 0] a
  .b(K_cal), // input [31 : 0] b
  .operation_nd(nd1), // input operation_nd
  .operation_rfd(mul_rfd1), // output operation_rfd
  .result(MulOut1), // output [31 : 0] result
  .underflow(), // output underflow
  .overflow(), // output overflow
  .invalid_op(), // output invalid_op
  .rdy(mul_rdy1) // output rdy
);

float_div float_div_inst (
  .a(Nom), // input [31 : 0] a
  .b(Denom), // input [31 : 0] b
  .operation_nd(div_nd), // input operation_nd
  .operation_rfd(div_rfd), // output operation_rfd
  .result(div_out), // output [31 : 0] result
  .underflow(div_underflw), // output underflow
  .overflow(div_overflw), // output overflow
  .invalid_op(div_invalid_op), // output invalid_op
  .divide_by_zero(divide_by_zero), // output divide_by_zero
  .rdy(div_rdy) // output rdy
);

//////////////////////chipscope//////////////////////////////
/*
wire [7:0] ila_trig = {4'b0,div_rdy,mul_rdy1,mul_rdy,data_valid};

wire [63:0] ila_data1,ila_data2;


assign ila_data1[4:0] = state;
assign ila_data1[5] = nd;
assign ila_data1[6] = mul_rfd;
assign ila_data1[7] = mul_rdy;

assign ila_data1[63:32] =MulA ;
assign ila_data2[31:0] = VGA ;
assign ila_data2[63:32] = MulOut;


ila_trig8 ila_trig8_inst1 (
    .CONTROL(ila_CONTROL0), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(ila_trig), // IN BUS [7:0]
	 .DATA(ila_data1) // IN BUS [127:0]
);
ila_trig8 ila_trig8_inst2 (
    .CONTROL(ila_CONTROL1), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(ila_trig), // IN BUS [7:0]
	 .DATA(ila_data2) // IN BUS [127:0]
);

*/

endmodule
