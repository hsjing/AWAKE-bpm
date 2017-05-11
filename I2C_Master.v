/*

I2C_Master.v - Verilog source for I2C module

Features:
- I2C Baud of 100Kbps or 400kbps
- ACK or NACK during READ is controlled via LSB of in_data
- SCL handshake (slave pulls SCL low to suspend master)

Limitations:
- Only supports master mode
- no IRQ support but has a busy bit that can be polled to assure module is not busy

Copyright (C) 2007  Steven Yu

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

comment: 
1. this module provides two speed for reading and writing data to SDA(one is 400k, the other is 100k)
2. Please reference on I2C protocal pattern to understand how does the master communicate with the slave
3. The general sequence on how to use this module in the top module is:
	a. Set wr = 1, addr = 0 to send the start bit
	b. Set wr = 0, rd = 1, addr = 4, so out_data outputs the status of I2C (wait until out_data[0] == 0, which means I2C is not busy)
	c. set wr = 1, addr = 2 or 3 depends on if master wants to write to slave or read from slave
	d. set wr = 0, rd = 1, addr = 4, and wait until out_data[0] is low 
	e. if master wants to keep writing to slave, please repeat step c and d / 
		if master wants to output the data it just read from slave, set wr = 0, rd = 1, addr = 3, so out_data will outputs 8 bit data at once
	f. don't forget to sent stop bits to finish the transmitting


*/

`define BAUD400K  25
`define BAUD100K  100

`define IDLE      0
`define START     1
`define STOP      2
`define READ      3
`define WRITE     4

module i2c_master(addr, in_data, out_data, sda, scl, cs, rd, wr, clk);
input wire [2:0] addr;
input wire [7:0] in_data;
output reg [7:0] out_data;
inout            sda;
inout            scl;
input wire       cs;
input wire       rd;
input wire       wr;
input wire       clk;

reg out_sda           = 1'b0;
reg out_scl           = 1'b0;

reg [7:0] in_buffer   = 8'b0;
reg [7:0] buffer      = 8'b0;

reg ack               = 1'b0;
reg speed             = 1'b0;

reg i2c_clk           = 1'b0;
reg [6:0] clk_count   = 7'b0;

reg [2:0] state	      = 3'b0;
reg [2:0] nextstate   = 3'b0;
reg [5:0] state_count = 6'b0;
reg [2:0] bit_count   = 3'b0;

wire busy;
wire held;

// I2C Clock
always@(posedge clk)
begin
	clk_count = clk_count + 1;
	
	if(speed)
	begin
		if(clk_count >= `BAUD400K)
		begin
			clk_count = 0;
		end
		
		// ~50/50 duty cycle
		if(clk_count > (`BAUD400K / 2))
		begin
			i2c_clk <= 1'b0;
		end
		else
		begin
			i2c_clk <= 1'b1;
		end
	end
	else
	begin
		if(clk_count >= `BAUD100K)
		begin
			clk_count = 0;
		end

		// ~50/50 duty cycle
		if(clk_count > (`BAUD100K / 2))
		begin
			i2c_clk <= 1'b0;
		end
		else
		begin
			i2c_clk <= 1'b1;
		end
	end
end

// Output Block
always@(addr or cs or rd or buffer or speed or ack or held or busy)
begin
    out_data = 8'bz;
    
    if(cs && rd)
    begin
        case(addr)
         // Data (read)
         3'b011:
         begin
            out_data = buffer;
         end

	 // Status
         3'b100:
         begin
            out_data = {4'b0, speed, ack, held, busy};
         end
      endcase
   end
end

// Input Block
always@(posedge clk)
begin
    nextstate <= nextstate;

    case(state)
        `IDLE:
        begin
            if(cs && wr && !busy)
            begin
                case(addr)
		
                    // Start
                    3'b000:
                    begin
                        nextstate <= `START;
                    end

                    // Stop
                    3'b001:
                    begin
                        nextstate <= `STOP;
                    end
			
                    // Read
                    3'b010:
                    begin
                        in_buffer = {7'b0, in_data[0]};
                        nextstate <= `READ;
                    end
			
                     // Data (write)
                    3'b011:
                    begin
                        in_buffer = in_data;
                        nextstate <= `WRITE;
                    end
			
                    // Speed
                    3'b100:
                    begin
                        speed = in_data[0];
                        nextstate <= `IDLE;
                    end
                endcase
            end
        end
        
        `START:
        begin
            if(state_count >= 6)
            begin
                nextstate <= `IDLE;
            end
        end
        
        `STOP:
        begin
            if(state_count >= 6)
            begin
                nextstate <= `IDLE;
            end
        end
        
        `READ:
        begin
            if(state_count >= 44)
            begin
                nextstate <= `IDLE;
            end
        end
        
        `WRITE:
        begin
            if(state_count >= 44)
            begin
                nextstate <= `IDLE;
            end
        end
    endcase
end

// state_count and bit_count
always@(posedge i2c_clk)
begin
   state <= nextstate;
   
   case(state)
       `START:
       begin
           if(state_count >= 6)
           begin
               state_count <= 0;
           end
           else
           begin
               state_count <= state_count + 1;
           end
       end

       `STOP:
       begin
           if(state_count >= 6)
           begin
               state_count <= 0;
           end
           else
           begin
               state_count <= state_count + 1;
           end
       end

       `READ:
       begin
           if(state_count >= 44)
           begin
               state_count <= 0;
           end
           else
           begin
               if(out_scl == scl)
               begin
                   state_count <= state_count + 1;
               end
               
           end
           
           if(bit_count >= 4)
           begin
               bit_count <= 0;
           end
           else
           begin
               if(out_scl == scl)
               begin
                   bit_count <= bit_count + 1;
               end
           end
       end

       `WRITE:
       begin
           if(state_count >= 44)
           begin
               state_count <= 0;
           end
           else
           begin
               if(out_scl == scl)
               begin
                   state_count <= state_count + 1;
               end
           end

           if(bit_count >= 4)
           begin
               bit_count <= 0;
           end
           else
           begin
               if(out_scl == scl)
               begin
                   bit_count <= bit_count + 1;
               end
           end
       end

   endcase        
end

// SDA and SCL
always@(posedge i2c_clk)
begin
   out_sda = out_sda;
   out_scl = out_scl;
    
   case(state)
       `START:
       begin
           case(state_count)
               0:
               begin
                   out_sda = 1'b1;
                   out_scl = 1'b1;
               end

               1:
               begin
                   out_sda = 1'b1;
                   out_scl = 1'b1;
               end

               2:
               begin
                   out_sda = 1'b1;
                   out_scl = 1'b1;
               end
               
               3:
               begin
                   out_sda = 1'b0;
                   out_scl = 1'b1;
               end
               
               4:
               begin
                   out_sda = 1'b0;
                   out_scl = 1'b1;
               end
               
               5:
               begin
                   out_sda = 1'b0;
                   out_scl = 1'b0;
               end
               
               6:
               begin
                   out_sda = 1'b0;
                   out_scl = 1'b0;
               end
           endcase
       end

       `STOP:
       begin
           case(state_count)
               0:
               begin
                   out_sda = 1'b0;
                   out_scl = 1'b0;
               end
               
               1:
               begin
                   out_sda = 1'b0;
                   out_scl = 1'b1;
               end
               
               2:
               begin
                   out_sda = 1'b0;
                   out_scl = 1'b1;
               end
               
               3:
               begin
                   out_sda = 1'b1;
                   out_scl = 1'b1;
               end
               
               4:
               begin
                   out_sda = 1'b1;
                   out_scl = 1'b1;
               end
               
               5:
               begin
                   out_sda = 1'b1;
                   out_scl = 1'b1;
               end
               
               6:
               begin
                   out_sda = 1'b1;
                   out_scl = 1'b1;
               end
           endcase
       end

       `READ:
       begin
           if(state_count >= 40)
           begin
               case(bit_count)
                   
                   0:
                   begin
                       out_sda = ~in_buffer[0];
                       out_scl = 1'b0;
                   end
                   
                   1:
                   begin
                       out_sda = ~in_buffer[0];
                       out_scl = 1'b0;
                   end
                   
                   2:
                   begin
                       out_sda = ~in_buffer[0];
                       out_scl = 1'b1;
                   end
                   
                   3:
                   begin
                       out_sda = ~in_buffer[0];
                       out_scl = 1'b1;
                   end
                   
                   4:
                   begin
                       out_sda = ~in_buffer[0];
                       out_scl = 1'b0;
                   end

               endcase
           end
           else
           begin
               case(bit_count)
                   
                   0:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b0;
                       
                       buffer = buffer << 1;
                   end
                   
                   1:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b0;
                   end
                   
                   2:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b1;
                   end
                   
                   3:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b1;
                       
                       buffer[0] = sda;
                   end
                   
                   4:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b0;
                   end
                   
               endcase
           end
       end
       
       `WRITE:
       begin
           if(state_count == 0)
           begin
               buffer = in_buffer;
           end
           
           if(state_count >= 40)
           begin
               case(bit_count)
                   
                   0:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b0;
                   end
                   
                   1:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b0;
                   end
                   
                   2:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b1;
                   end
                   
                   3:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b1;
                       
                       ack = sda;
                   end
                   
                   4:
                   begin
                       out_sda = 1'b1;
                       out_scl = 1'b0;
                   end
                   
               endcase
           end
           else
           begin
               case(bit_count)
                   
                   0:
                   begin
                       out_sda = buffer[7];
                       out_scl = 1'b0;
                   end
                   
                   1:
                   begin
                       out_sda = buffer[7];
                       out_scl = 1'b0;
                   end
                   
                   2:
                   begin
                       out_sda = buffer[7];
                       out_scl = 1'b1;
                   end
                   
                   3:
                   begin
                       out_sda = buffer[7];
                       out_scl = 1'b1;
                   end
                   
                   4:
                   begin
                       out_sda = buffer[7];
                       out_scl = 1'b0;
                       
                       buffer = buffer << 1;
                   end
                   
               endcase
           end
       end
   endcase
end

assign sda = out_sda ? 1'bz : 1'b0;
assign scl = out_scl ? 1'bz : 1'b0;


assign busy = (state != `IDLE || nextstate != `IDLE) ? 1 : 0;
assign held = out_scl != scl;

endmodule