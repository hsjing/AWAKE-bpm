`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shengli Liu
// 
// Create Date:    23:42:17 07/22/2016 
// Design Name: 
// Module Name:    SPI 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: Write/Read SPI port of ADC, only support write/read 1 byte data to/from
//  an address at one time.
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SPI_Master(
   input clk,
	input rst,
	input [12:0] addr_tx, //only 13 bit addr is used.
	input [7:0] data_tx, //data sent to Slave
	output [7:0] data_rx, //data received from Slave
	input wr, //start write transaction, multiple clk wide pulse
	input rd, //start read transaction, multiple clk wide pulse
	output rdy,  //received data ready
	output SCLK,
	inout SDIO,
	output CSB
    );

parameter state_idle = 0,
			 state_wr1 = 1,
			 state_wr2 = 2,
			 state_wr3 = 3,
			 state_wr4 = 4,
			 state_wr5 = 5,
			 state_wr_addr1 = 6,
			 state_wr_addr2 = 7,
			 state_wait = 8,
			 state_wr_data1 = 9,
			 state_wr_data2 = 10,
			 state_rd_data1 = 11,
			 state_rd_data2 = 12,
			 state_done = 13,
			 state_wait4 = 14,
			 state_wait5 = 15;
reg rdy;	
reg drv_SDIO,SDIO_out;
reg CSB,SCLK;	
	
reg [7:0] data, data_rx;
reg [12:0] addr;
reg wr_flag;
reg [3:0] state;
reg [3:0] cnt;

assign SDIO = drv_SDIO? SDIO_out :1'bz;
			 
always @(posedge clk)
begin
	if(rst)
		begin
			state <= state_idle;
			rdy <= 0; drv_SDIO <= 1;
			CSB <= 1; SDIO_out <= 0; SCLK <= 0; 
		end	
	else
		begin
			case(state)
				state_idle:
					begin
						rdy <= 0; drv_SDIO <= 1; cnt <= 0; CSB <= 1;
						if(wr) 
						   begin 
							   addr <= addr_tx; data <= data_tx; 
								CSB <= 0; SCLK <= 0; 
								wr_flag <= 1; SDIO_out <= 0; 
								state <= state_wr1; 
							end
						if(rd) 
						   begin 
							   addr <= addr_tx; 
								CSB <= 0; SCLK <= 0; 
								wr_flag <= 0; SDIO_out <= 1; 
								state <= state_wr1; 
							end
					end
				state_wr1:	
				   begin SCLK <= 1; state <= state_wr2; end
				state_wr2:	
				   begin SCLK <= 0; SDIO_out <= 0; state <= state_wr3; end
				state_wr3:	
				   begin SCLK <= 1;  state <= state_wr4; end	
				state_wr4:	
				   begin SCLK <= 0;  state <= state_wr5; end
				state_wr5:	
				   begin SCLK <= 1;  state <= state_wr_addr1; end	
            state_wr_addr1:	
				   begin SCLK <= 0;  
					      SDIO_out <= addr[12];
					      cnt <= cnt + 1; 
							state <= state_wr_addr2;
					end
				state_wr_addr2:	
				   begin SCLK <= 1;
							addr <= addr << 1;
							if (cnt >= 13) begin cnt <= 0; state <= state_wait; end
							else state <= state_wr_addr1;
					end
            state_wait:
               begin if (wr_flag) state <= state_wr_data1; 
                     else 	begin drv_SDIO <= 0; state <= state_rd_data1; end	
               end							
            state_wr_data1:	
				   begin SCLK <= 0;  
					      SDIO_out <= data[7];
					      cnt <= cnt + 1; 
							state <= state_wr_data2;
					end
				state_wr_data2:	
				   begin SCLK <= 1;
							data <= data << 1;
							if (cnt >= 8) state <= state_done; 
							else state <= state_wr_data1;
					end	
            state_rd_data1:	
				   begin SCLK <= 0;  
							state <= state_rd_data2;
					end
				state_rd_data2:	
				   begin SCLK <= 1;
							data <= {SDIO,data[6:0]};
					      cnt <= cnt + 1; 
							if (cnt >= 8) begin data_rx <= data; rdy <= 1; state <= state_done; end
							else begin data <= data >> 1; state <= state_rd_data1; end
					end					
				state_done:
				   begin SCLK <= 0;  
					      SDIO_out <= 0;
							CSB <= 1;
							rdy <= 0;
							drv_SDIO <= 1;
							if ( ~wr && ~rd ) state <= state_idle;
					end
				
			default: 
				begin
					state <= state_idle;
				end
		endcase
	end
end
				
endmodule

