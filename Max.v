`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:22 04/06/2017 
// Design Name: 
// Module Name:    Max 
// Project Name: 
// Target Devices: 
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
module Max(
   
	input Input_valid,
	
	input [63:0] DATAIN,	//data from ADC deserializer
	input clk,
	input rst,
	
	output reg [15:0] Max_A,
	output reg [15:0] Max_B,
	output reg [15:0] Max_C,
	output reg [15:0] Max_D,

	output reg over_flow_A,
	output reg over_flow_B,
	output reg over_flow_C,
	output reg over_flow_D
	
    );

parameter  	ADC_BIT_WIDTH = 16;
parameter  	DATA_WIDTH = 16;
parameter   ADC_TH = 30000;  //16 bit ADC threshold value (max 32768), beyond this will be regarded as overflow.

wire [ADC_BIT_WIDTH-1:0] din_a = DATAIN[15:0];
wire [ADC_BIT_WIDTH-1:0] din_b = DATAIN[31:16];
wire [ADC_BIT_WIDTH-1:0] din_c = DATAIN[47:32];
wire [ADC_BIT_WIDTH-1:0] din_d = DATAIN[63:48];

parameter idle = 0, compare_1 = 1, done = 2;
		  

reg [1:0] state;
reg [DATA_WIDTH-1:0] Old_Max_A,Old_Max_B,Old_Max_C,Old_Max_D;
reg result_valid;

//wire Abs_a[14:0] = din_a[15]? ~din_a[14:0] + 1
//					  : din_a[14:0];				  
//wire Abs_b[14:0] = din_b[15]? ~din_b[14:0] + 1
//					  : din_b[14:0];
//wire Abs_c[14:0] = din_c[15]? ~din_c[14:0] + 1
//					  : din_c[14:0];
//wire Abs_d[14:0] = din_d[15]? ~din_d[14:0] + 1
//					  : din_d[14:0];
					  
always @ (posedge clk)
begin
	if(rst)	
		begin 
			Old_Max_A <= 0; Old_Max_B <= 0; Old_Max_C <= 0; Old_Max_D <= 0;	
			result_valid <= 0;
			state <= idle;
		end
	else 
		case(state)
				idle: 
					if(Input_valid)  
						begin 
							Old_Max_A <= 0; Old_Max_B <= 0; Old_Max_C <= 0; Old_Max_D <= 0;
							result_valid <= 0;
							state <= compare_1; 
						end	
				compare_1:		
					begin 
						if (Input_valid) 
							begin 
								if ((din_a[15]==0) && (din_a[14:0] > Old_Max_A[14:0])) Old_Max_A <= din_a;
								if ((din_b[15]==0) && (din_b[14:0] > Old_Max_B[14:0])) Old_Max_B <= din_b;
								if ((din_c[15]==0) && (din_c[14:0] > Old_Max_C[14:0])) Old_Max_C <= din_c;	
								if ((din_d[15]==0) && (din_d[14:0] > Old_Max_D[14:0])) Old_Max_D <= din_d;
							end
						else 	state <= done;		
					end
				done: 
					begin
						result_valid <= 1;
						state <= idle;
					end
				default:
					begin 
							Old_Max_A <= 0; Old_Max_B <= 0; Old_Max_C <= 0; Old_Max_D <= 0;
							result_valid <= 0;
							state <= idle; 
					end
		endcase			
end

always @ (posedge clk)
	if (result_valid) 
		begin 		
			Max_A <= Old_Max_A; Max_B <= Old_Max_B; Max_C <= Old_Max_C; Max_D <= Old_Max_D;
			over_flow_A <= (Max_A[14:0] > ADC_TH); 
			over_flow_B <= (Max_B[14:0] > ADC_TH);
			over_flow_C <= (Max_C[14:0] > ADC_TH);
			over_flow_D <= (Max_D[14:0] > ADC_TH);
		end	

endmodule
