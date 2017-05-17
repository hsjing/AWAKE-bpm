`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  TRIUMF
// Engineer: Shengli Liu
// 
// Create Date:    13:15:31 03/21/2017 
// Design Name: 
// Module Name:    VGA 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// Multiply Digital Attenuater setting and VGA gain to ChX_Power signal, 0 ~ 31 dB. to recover 
// the real value of the input signal.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGA(
	input clk,
	input rst,
	input datain_valid,
	input [4:0] DIGI_att,
   	input [4:0] VGA_gain,
   	
   	/* Digital attenuation coefficients input here */
   	input [SF_WIDTH-1:0] ChA_9dB,
	input [SF_WIDTH-1:0] ChB_9dB,
	input [SF_WIDTH-1:0] ChC_9dB,
	input [SF_WIDTH-1:0] ChD_9dB,
	
	/* VGA attenuation input here */	
	input [SF_WIDTH-1:0] ChA_Power,
	input [SF_WIDTH-1:0] ChB_Power,
	input [SF_WIDTH-1:0] ChC_Power,
	input [SF_WIDTH-1:0] ChD_Power,	
	
	/* Final attenuation compensation coefficient */
	output reg [SF_WIDTH-1:0] ChA_Power_Out,
	output reg [SF_WIDTH-1:0] ChB_Power_Out,
	output reg [SF_WIDTH-1:0] ChC_Power_Out,
	output reg [SF_WIDTH-1:0] ChD_Power_Out,
	
	/* Adjustment ready flag */
	output reg Adj_rdy
    );
	 
	parameter  	DATA_WIDTH = 16;
	parameter  	SF_WIDTH = 32;
	
	/* VGA attenuation coefficients (assumed accurate, therefore is simply the hex value of x dB inversed) */
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
			A_DIGI = 9,  A_DIGI_WAIT = 10,
			B_DIGI = 11, B_DIGI_WAIT = 12,
			C_DIGI = 13, C_DIGI_WAIT = 14,
			D_DIGI = 15, D_DIGI_WAIT = 16, 
			done = 17;
			 
	reg nd; //new data command to multiplier
	wire mul_rdy; //Multiplier output data is ready.
	wire mul_rfd; //Multiplier ready for data
	reg [31:0] MulA;
	reg [31:0] MulB;
	wire [31:0] MulOut;
	
	/* Temporary storage for VGA compensation coefficients */
	reg [SF_WIDTH-1:0] ChA_Power_Adj;
	reg [SF_WIDTH-1:0] ChB_Power_Adj;
	reg [SF_WIDTH-1:0] ChC_Power_Adj;
	reg [SF_WIDTH-1:0] ChD_Power_Adj;
	
	reg [4:0] state;
	
	always @ (posedge clk) begin
		
		/* Reset parameters by zeroing all coefficient storage, etc */
		if(rst) begin
			state <= idle;
			ChA_Power_Adj <= 0;
			ChB_Power_Adj <= 0;
			ChC_Power_Adj <= 0;
			ChD_Power_Adj <= 0;
			Adj_rdy <= 0;
			nd <= 0;
			end
		
		/* Othrewise begin state-machine */
		else begin
			case(state)

				idle:
					begin
						Adj_rdy <= 0;
						nd <= 0;
						if(datain_valid)  state <= A_GAIN;
					end

				/* Begin of VGA gain compensaton */
				A_GAIN:
				   	if(mul_rfd) begin
				   		MulB <= VGA;
						MulA <= ChA_Power;
						nd <= 1;
						state <= A_GAIN_WAIT;
						end

				A_GAIN_WAIT:
					begin
				  	nd <= 0;
			     	if(mul_rdy) begin
						ChA_Power_Adj <= MulOut;
						state <= B_GAIN;
						end
					end

				B_GAIN:
					if (mul_rfd) begin
						MulA <= ChB_Power;
						nd <= 1;
						state <= B_GAIN_WAIT;
						end

				B_GAIN_WAIT:
			   		begin
				  	nd <= 0;
					if(mul_rdy) begin
						ChB_Power_Adj <= MulOut;
						state <= C_GAIN;
						end
					end

				C_GAIN:
				   	if(mul_rfd) begin
				   		MulA <= ChC_Power;
						nd <= 1;
						state <= C_GAIN_WAIT;
						end

				C_GAIN_WAIT:
			   		begin
				  	nd <= 0;
			     	if(mul_rdy) begin
						ChC_Power_Adj <= MulOut;
						state <= D_GAIN;
						end
					end

				D_GAIN:
				   	if (mul_rfd) begin 
				   		MulA <= ChD_Power;
						nd <= 1;
						state <= D_GAIN_WAIT;
					  end
	
				D_GAIN_WAIT:
					begin
				  	nd <= 0;
			     	if(mul_rdy) begin
						ChD_Power_Adj <= MulOut;
						state <= A_DIGI;
					 	end					 	
					end
				
				/* Beginning of digital gain compensation */
				A_DIGI:			
					if (mul_rfd) begin
						MulA <= ChA_Power_Adj;
						MulB <= DIGI_A;
						nd <= 1; 
						state <= A_DIGI_WAIT; 
					  end

				A_DIGI_WAIT:
			   		begin
				  	nd <= 0;
			     	if(mul_rdy) begin
						ChA_Power_Out <= MulOut;
						state <= B_DIGI;
						end
					end

				B_DIGI:				
					if(mul_rfd) begin
						MulA <= ChB_Power_Adj;
						MulB <= DIGI_B;
						nd <= 1; 
						state <= B_DIGI_WAIT;
						end
					
				B_DIGI_WAIT:
			   		begin
				  	nd <= 0;
			     	if(mul_rdy) begin
						ChB_Power_Out <= MulOut;
						state <= C_DIGI;
						end
					end

				C_DIGI:				
				   	if(mul_rfd) begin
				   		MulA <= ChC_Power_Adj;
				   		MulB <= DIGI_C; 
						nd <= 1; 
						state <= C_DIGI_WAIT;
						end

				C_DIGI_WAIT:
			   		begin
					nd <= 0;
			     	if(mul_rdy) begin
						ChC_Power_Out <= MulOut;
						state <= D_DIGI;
						end
					end

				D_DIGI:				
				   	if(mul_rfd) begin
				   		MulA <= ChD_Power_Adj;
				   		MulB <= DIGI_D;
						nd <= 1;
						state <= D_DIGI_WAIT;
						end

				D_DIGI_WAIT:
			   		begin
				  	nd <= 0;
			     	if(mul_rdy) begin
			     		ChD_Power_Out <= MulOut;
						state <= done;
						end
					end				
				
				/* Done */
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

	/* Switches between compensation coefficients depending on attenuation setting */
	wire [SF_WIDTH-1:0] DIGI_A = DIGI_att == 0? dB0
				:DIGI_att == 9? ChA_9dB
				:dB0;

	wire [SF_WIDTH-1:0] DIGI_B = DIGI_att == 0? dB0
				:DIGI_att == 9? ChB_9dB
				:dB0;
				 
	wire [SF_WIDTH-1:0] DIGI_C = DIGI_att == 0? dB0
				:DIGI_att == 9? ChC_9dB
				:dB0;
				 
	wire [SF_WIDTH-1:0] DIGI_D = DIGI_att == 0? dB0
				:DIGI_att == 9? ChD_9dB
				:dB0;

	/* Switches between compensation coefficients depending on attenuation setting */
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
