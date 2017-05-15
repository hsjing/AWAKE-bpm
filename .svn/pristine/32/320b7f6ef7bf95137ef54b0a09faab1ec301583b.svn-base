module LED(
    input trig,
    input clk,
    input rst,
    output reg LED
);

parameter WAIT_TIME = 30000000; //cycle
parameter state_idle = 0;
parameter state_LED = 1;
parameter state_done = 2;

reg [1:0] state;
reg [24:0] CNT;
 
always @(posedge clk)
begin
  if(rst)
    begin
      state <= state_idle;
      CNT <= 0;
      LED <= 0;
    end
  
  else
   begin
      case(state)
       state_idle:
        if(trig)
          begin
            LED <= 1;
            CNT <= 1;
            state <= state_LED;
          end
        
        
       state_LED:
        begin
          CNT <= CNT + 1;
          if(CNT >= WAIT_TIME) 
            state <= state_done;
        end
        
       state_done:
        begin
          LED <= 0;
          state <= state_idle;
        end 
    endcase
  end
end




endmodule