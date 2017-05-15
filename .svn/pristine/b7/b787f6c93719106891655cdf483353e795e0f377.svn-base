`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Angela Zhou
// 
// Create Date:    10:01:35 02/19/2016 
// Design Name: 
// Module Name:    trigger 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// this module outputs a trig signal based on internal and external trig. 
// once trig outputs high, circular buffer starts loading the event data 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// modified by SL: 
// July14,2016: added internal trigger mode, 1.49Hz trigger for testing/caliberation purpose
//

//////////////////////////////////////////////////////////////////////////////////
module trigger(
   input [1:0] TRIG_MODE,
	input VETO,
   input RUN,
	input [63:0] DATAIN,	//data from deserializer
	input CLK,
	input RESET,
	input EXT_TRIG,
	input [15:0] THRESHOLD,
	input [15:0] DEAD_TIME,
	input [15:0] TRIG_DELAY,
	output TRIG
);

//Internal trigger mode: triggered @ 1 Hz to drive external pulser or check noise level, don't care about input
reg [25:0] int_trig_cnt; //to generate 1.49Hz pulse from 100MHz
always @ (posedge CLK)
   int_trig_cnt <= int_trig_cnt + 1;

wire int_trig = &int_trig_cnt[25:4]; //the pulse width is 16*10 ns 

//Self trigger mode: triggered when input signal amplitude exceeds pre-defined Threshold	
parameter  state_idle = 2'b0,
	        state_event = 2'b01,
			  state_dead = 2'b11;
			  
	reg [1:0] state;
	reg [15:0] count;
	reg sf_trig;
	
always @ (posedge CLK)
begin
	
	if(RESET)begin
		state <= state_idle;			//if reset, state = state_noise, trigA off
		sf_trig <= 0;
	end
	
	else begin
		case(state)
		state_idle:
			if((  (DATAIN[63:48] > THRESHOLD)&& ( DATAIN[63]==0)) 
			   | ((DATAIN[47:32] > THRESHOLD) && (DATAIN[47] == 0)) 
				| ((DATAIN[31:16] > THRESHOLD) && (DATAIN[31]==0)) 
				| ((DATAIN[15:0] > THRESHOLD)&&(DATAIN[15]==0))) 
			  if (RUN && ~VETO) begin 
				  state <= state_event;
				  sf_trig <= 1;
				  count <= DEAD_TIME;
			  end
			
		state_event:
		begin
			sf_trig <= 0;
			state <= state_dead;
		end
		
		state_dead:
		begin
			if(count <= 1)
			begin
				state <= state_idle;
			end
			else 
			begin
				count <= count - 1;
			end
		end
			
			
		default:
		begin
		sf_trig <= 0;
		state <= state_idle;
		end
		endcase
	end
end

//External trigger mode/////////////////////////////////////////////
//Synchronize, delay and Shape external trigger pulse

reg [15:0] trig_delay_cnt; //16 bit allows 640 us delay for 100MHz clock
reg ex_trig_syn1,ex_trig_syn2;

always @ (posedge CLK) 
  begin 
		ex_trig_syn1 <= EXT_TRIG;
		ex_trig_syn2 <= ex_trig_syn1;
  end

parameter  delay_state_idle = 2'b0,
	        delay_state_cnt = 2'b01,
			  delay_state_event = 2'b10;

			  
reg [1:0] delay_state;
reg ex_trig_delayed; //one clock wide
	
always @ (posedge CLK) begin
	if(RESET)begin
		  delay_state <= delay_state_idle;	 
		  ex_trig_delayed <= 0;
	   end
   else begin
	 case(delay_state)
		delay_state_idle:
		   if(ex_trig_syn2 == 1  && ~VETO) begin trig_delay_cnt <= 0;	delay_state <= delay_state_cnt; end 
		delay_state_cnt:
			if (trig_delay_cnt >= TRIG_DELAY) begin ex_trig_delayed <= 1; delay_state <= delay_state_event; end 	
         else 	trig_delay_cnt <= trig_delay_cnt + 1;		
		delay_state_event:
		   begin
			  ex_trig_delayed <= 0;
			  delay_state <= delay_state_idle; 	
			end 
		default:
				begin ex_trig_delayed <= 0; delay_state <= delay_state_idle; end
	 endcase
	end

end //always
  

parameter  trig_state_idle = 2'b0,
	        trig_state_event = 2'b01,
			  trig_state_DT = 2'b10;

			  
reg [1:0] trig_state;
reg [15:0] DT_count; //for dead time
reg ex_trig; //one clock wide
	
always @ (posedge CLK) begin
	if(RESET)begin
		  trig_state <= trig_state_idle;	
		  ex_trig <= 0;
	   end
   else begin
	 case(trig_state)
		trig_state_idle:
		   if(ex_trig_delayed == 1) begin ex_trig <= 1; trig_state <= trig_state_event; end 
		trig_state_event:
		   begin
			  ex_trig <= 0; 
			  DT_count <= 0;
			  trig_state <= trig_state_DT; 	
			end 
		trig_state_DT:	
		   if(DT_count >= DEAD_TIME) trig_state <= trig_state_idle;
			else DT_count <= DT_count + 1;
			
		
		default:
				begin ex_trig <= 0; trig_state <= trig_state_idle; end
	 endcase
	end

end //always

wire EX_TRIG_MODE   = (TRIG_MODE[1] == 0) && (TRIG_MODE[0] == 0);
wire SELF_TRIG_MODE = (TRIG_MODE[1] == 0) && (TRIG_MODE[0] == 1);
wire INT_TRIG_MODE  = (TRIG_MODE[1] == 1) && (TRIG_MODE[0] == 0);

assign TRIG = EX_TRIG_MODE? ex_trig
              :SELF_TRIG_MODE? sf_trig
				  :INT_TRIG_MODE? int_trig
				  :0;				

endmodule
