`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:58 07/14/2016 
// Design Name: 
// Module Name:    cal_schedule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
// Caliberation schedule scheme:
// every real event is followed by a cal event;
// cal event is labeled by cal_flag;

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cal_schedule(
   input [1:0] TRIG_MODE,
	input Cal_ST, //in Static Cal_mode,
   input Cal_OL, //in Online cal mode, 
	input clk, //10 MHz clock
	input rst,
	
	input packing_done, //this is one clk wide
	
	output cal_trig,  //one clk wide, 100 ns, this is ok!
	output cal_on,
	output cal_flag   //to mark the current event, asserted until poisiton_rdy

    );

parameter state_idle = 0;
parameter state_1 = 1;
parameter state_2 = 2;
parameter state_3 = 3;
parameter state_4 = 4;
parameter state_5 = 5;


reg [2:0] state;
reg [17:0] count; //wait 20 ms for SW to settle down

reg cal_trig, cal_flag, cal_on;
wire EX_TRIG_MODE   = (TRIG_MODE[1] == 0) && (TRIG_MODE[0] == 0);
 
always @(posedge clk)
begin
  if(rst)
    begin  state <= state_idle; cal_trig <= 0; cal_flag <= 0; cal_on <= 0; count <= 0; end
  else
      case(state)
        state_idle: 
				begin 
					count <= 0;
					if(EX_TRIG_MODE && packing_done && ~cal_flag && ~Cal_ST && Cal_OL) 
						state <= state_1;
			   end				
		  state_1: begin cal_flag <= 1; cal_on <= 1; state <= state_2; end
		  state_2: 
				begin
					count <= count + 1;
					if (count >= 18'd262100) begin cal_trig <= 1; state <= state_3; end
				end	
		  state_3: begin cal_trig <= 0; state <= state_4;end
		  state_4: if (packing_done) begin cal_flag <= 0; cal_on <= 0; state <= state_5; end
		  state_5: if (~packing_done) state <= state_idle; 
		  default: state <= state_idle;
		endcase 
end//always


endmodule
