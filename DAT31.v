//DAT31.v: MINI-Circuit DAT-31R5-SP digital attenuator serial interface
//Shengli Liu, March27,2017


`timescale 1 ns / 1 ps

module DAT31(
	input clk, //10MHz clk
	input rst,

	input write, //one clk wide pulse,100ns
	
	output reg att_le,
	output reg att_clk,
	output reg att_data,
	
	input [5:0] setting
);

parameter idle = 0,
 		  state_1 = 1, state_1_wait = 2,
		  state_2 = 3, state_2_wait = 4,
		  state_3 = 5, state_3_wait = 6,
		  state_4 = 7, state_4_wait = 8,
		  state_5 = 9, state_5_wait = 10,
		  state_6 = 11,state_6_wait = 12,
		  state_7 = 13, state_7_wait = 14;

reg [3:0] state;
reg [5:0] old_setting;

always @(posedge clk)
begin
	if(rst)	begin att_le <= 0; att_clk <= 0; att_data <= 0; old_setting <= 0; state <= idle; end
	else 
		begin
			case(state)
			idle:
					begin
						att_le <= 0; att_clk <= 0;
						if(setting != old_setting)  state <= state_1; 
					end					
			state_1:				
				    begin 
				        att_data <= setting[5]; 
						state <= state_1_wait; 
					end							
			state_1_wait:
			        begin 
				        att_clk <= 1; 
						state <= state_2; 
					end

			state_2:				
				   begin 
				        att_clk <= 0; 
				        att_data <= setting[4]; 
						state <= state_2_wait; 
					end								
			state_2_wait:
			        begin 
				        att_clk <= 1; 
						state <= state_3; 
					end

			state_3:				
				   begin 
				        att_clk <= 0; 
				        att_data <= setting[3]; 
						state <= state_3_wait; 
					end								
			state_3_wait:
			        begin 
				        att_clk <= 1; 
						state <= state_4; 
					end
			state_4:				
				   begin 
				        att_clk <= 0; 
				        att_data <= setting[2]; 
						state <= state_4_wait; 
					end								
			state_4_wait:
			        begin 
				        att_clk <= 1; 
						state <= state_5; 
					end
			state_5:				
				   begin 
				        att_clk <= 0; 
				        att_data <= setting[1]; 
						state <= state_5_wait; 
					end								
			state_5_wait:
			        begin 
				        att_clk <= 1; 
						state <= state_6; 
					end
			state_6:				
				   begin 
				        att_clk <= 0; 
				        att_data <= setting[0]; 
						state <= state_6_wait; 
					end								
			state_6_wait:
			        begin 
				        att_clk <= 1; 
						state <= state_7; 
					end				
			state_7:
				begin 
				        att_clk <= 0; 
				        att_data <= setting[0]; 
						state <= state_7_wait; 
					end								
			state_7_wait:
			        begin 
				        att_le <= 1; 
				        old_setting <= setting;
						state <= idle; 
					end			
			
			default:	state <= idle;
			
		endcase 
	end
	
end
			
endmodule