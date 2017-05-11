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

parameter idle = 0,
			 A_Div = 1, A_Div_WAIT = 2,
			 B_Div = 3, B_Div_WAIT = 4,
			 C_Div = 5, C_Div_WAIT = 6,
			 D_Div = 7, D_Div_WAIT = 8, 
			 done = 9;
			 
reg div_nd;
wire div_rfd;
reg [SF_WIDTH-1:0] Denom, Nom;
wire [SF_WIDTH-1:0] div_out;

reg [3:0] state;

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
			div_nd <= 0;
		end
	else 
		begin
			case(state)
			idle:
					begin
						Corr_rdy <= 0;
						if(data_valid)  state <= A_Div; 
					end					
			A_Div: 
				if (div_rfd) 
					  begin 
							  Nom <= K_cal;	
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
					  begin Denom <= B_Cal;
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
					  begin Denom <= C_Cal;
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
					  begin Denom <= D_Cal;
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
