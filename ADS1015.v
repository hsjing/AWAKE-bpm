//ADS1015.v
//Angela Zhou March10,2016

//only support:
//write 2 byte to AD7417 register;
//write 1 byte to AD7417 pointer register;
//read 2 bytes from AD7417 register;

//default data rate: 1600SPS = 0.625ms per conversion
//default device operating mode: single-shot
//default input mux: differential value between chanel A and chanel B(should reference to datasheet to pick the correct input mux config)
//the I2C protocal code is inside of ADS1015 module, the top module uses a FSM to control wr, rd and addr signals that will change the operation mode in I2C_master_inst

`timescale 1 ns / 1 ps

module ADS1015(
	input clk, //slow clock
	input request,
	input rst,
	inout SDA,
	//input SDA,
	output SCL,
	output reg rdy, //output a ready signal when 
	output reg [15:0] chA_temp,
	output reg [15:0] chB_temp,
	output reg [15:0] chC_temp,
	output reg [15:0] chD_temp
);

//based on datasheet
parameter SLAVE_ADDR_WR = 8'b10010010; 
parameter SLAVE_ADDR_RD = 8'b10010011;
parameter CONVERSION_REG = 8'b0;
parameter CONFIG_REG = 8'b00000001;
parameter LO_THRESH_REG = 8'b00000010;
parameter HI_THRESH_REG = 8'b00000011;
parameter CHA = 3'b100;
parameter CHB = 3'b101;
parameter CHC = 3'b110;
parameter CHD = 3'b111; 

//FSM for reading temperature: 1.send start bit 
//										 2.send slave addr + 0(indicate write) 
//										 3.send pointer reg addr + config reg addr
//										 4.send settings to config reg 
//										 5.send stop bit 
//										 6.send a start bit 
//										 7.send slave addr + 1(indicate read)
//										 8. receive MSB 8 bits of data
//										 9. output MSB 8 bits data
//										 10. receive LSB 8 bits of data
//										 11. output LSB 8 bits of data
//										 12. send stop bit


parameter state_idle = 0;
parameter state_wait = 1;
parameter state_start_bit = 2;
parameter state_wait1 = 3;
parameter state_status1 = 4;
parameter state_slave_write = 5;
parameter state_pointerReg_write = 6;
parameter state_configReg_write1 = 7;
parameter state_configReg_write2 = 8;
parameter state_stop1 = 9;
parameter state_start_bit2 = 10;
parameter state_slave_write2 = 11;
parameter state_pointerReg_read = 12;
parameter state_stop2 = 13;
parameter state_start_bit3 = 14;
parameter state_slave_read = 15;
parameter state_read_data1 = 16;
parameter state_config_output1 = 17;
parameter state_read_temp1 = 18;
parameter state_read_data2 = 19;
parameter state_config_output2 = 20;
parameter state_read_temp2 = 21;
parameter state_stop3 = 22;
parameter state_done = 23;


reg [2:0] i2c_addr;
reg [7:0] in_data;
wire [7:0] out_data;  
reg        i2c_cs;
reg        i2c_rd;
reg        i2c_wr;
reg [3:0] CNT;
reg [2:0] channelCNT;
wire [15:0] configRegA = 16'b1100010110000011;
wire [15:0] configRegB = 16'b1101010110000011;
wire [15:0] configRegC = 16'b1110010110000011;
wire [15:0] configRegD = 16'b1111010110000011;


i2c_master i2c_master_inst(
   .addr(i2c_addr), 
   .in_data(in_data), 
   .out_data(out_data), 
   .sda(SDA), 
   .scl(SCL), 
   .cs(i2c_cs), 
   .rd(i2c_rd), 
   .wr(i2c_wr), 
   .clk(clk)
);

reg [5:0]state;
always @(posedge clk)
begin
	if(rst)
	begin
		state <= state_idle;
		i2c_addr <= 0;
		in_data <= 0;
		i2c_cs <= 1;
		i2c_rd <= 0;
		i2c_wr <= 0;
		rdy <= 0;
		CNT <= 0;
		channelCNT <= 0;
		chA_temp <= 0;
		chB_temp <= 0;
		chC_temp <= 0;
		chD_temp <= 0;	
	end

	else 
	begin
		case(state)
			state_idle:		//0 clear all parameters, if request is low, go to next state
			begin
				i2c_addr <= 0;
				in_data <= 0;
				i2c_cs <= 1;
				i2c_rd <= 0;
				i2c_wr <= 0;
				rdy <= 0;
				CNT <= 0;
				channelCNT <= 0;
				if(!request) state <= state_wait;
			end
			
			state_wait:		//1 wait until the rising edge of request(from low to high), go to next state
			begin
				if(request) state <= state_start_bit; 
			end	

			state_start_bit:		//2 start sending the start bit, set addr = 0,cs = 1, wr = 1 so the FSM in i2c_master is in start state
			begin
				i2c_addr <= 0;
				i2c_wr <= 1;
				state <= state_wait1;
				CNT <= 0;
				

			end

			state_wait1:		//3 set cs,wr = 0. state3,4 is reused
			begin
				i2c_wr <= 0;
				state <= state_status1;
				CNT <= CNT + 1;
			end

			state_status1:		//4 set addr = 4, cs,rd = 1, so out_data outputs the status of i2c, out_data[0] shows busy status(refer to i2c_master.v
			begin					//once the busy signal is low(which FSM in i2c_master is back to idle state, to indicate start bit has send), go to next state
				i2c_addr <= 4;
				i2c_rd <= 1;
				if(out_data[0] == 0)
					begin
						i2c_rd <= 0;
					  case(CNT)    
					    1: 
					    state <= state_slave_write;
					    2:
					    state <= state_pointerReg_write;
					    3:
					    state <= state_configReg_write1;
					    4:
					    state <= state_configReg_write2;
					    5: 
					    state <= state_stop1;
					    6:
					    state <= state_start_bit2;
					    7: 
					    state <= state_slave_write2;
					    8:
					    state <= state_pointerReg_read;
					    9:
					    state <= state_stop2;
					    10:
					    state <= state_start_bit3;
					    11:
					    state <= state_slave_read;
					    12: 
					    state <= state_read_data1;
					    13:
					    state <= state_config_output1;
					    14:
					    state <= state_config_output2;
					    15: 
					    state <= state_done;
					    default:
					    state <= state_slave_write;
					  endcase
					end
			end

			state_slave_write:		//5 set i2c_adr = 3,cs,wr = 1 to indicate i2c is in writing state, in_data gets slave adddress + 0
			begin
				i2c_addr <= 3;
				in_data <= SLAVE_ADDR_WR;
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 2;
			end

			state_pointerReg_write:		//6 write pointer register to point to the configer register
			begin
				i2c_addr <= 3;
				in_data <= CONFIG_REG;
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 3;
			end

			state_configReg_write1:		//7 write to 8 bit MSB configure register to set OS high and the corresponding chanal to read the temperature
			begin
				i2c_addr <= 3;
				case(channelCNT)
				  0:
				  in_data <= configRegA[15:8];
				  1:
				  in_data <= configRegB[15:8];
				  2:
				  in_data <= configRegC[15:8];
				  3:
				  in_data <= configRegD[15:8];
				  default:
				  in_data <= configRegA[15:8];
				endcase
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 4;
			end

			state_configReg_write2:		//8 write to 8 bit LSB to config register
			begin
				i2c_addr <= 3;
				case(channelCNT)
				  0:
				  in_data <= configRegA[7:0];
				  1:
				  in_data <= configRegB[7:0];
				  2:
				  in_data <= configRegC[7:0];
				  3:
				  in_data <= configRegD[7:0];
				  default:
				  in_data <= configRegA[7:0];
				endcase
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 5;
			end	
			
			state_stop1:	//9 once done sending settings send a stop bit
			begin
				i2c_addr <= 1;
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 6;
			end


			state_start_bit2:		//10 send a start bit to start read
			begin
				i2c_addr <= 0;
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 7;
			end
			
			state_slave_write2:
			begin
			  i2c_addr <= 3;
			  in_data <= SLAVE_ADDR_WR;
			  i2c_wr <= 1;
			  state <= state_wait1;
			  //CNT <= 8;
			end
			
			state_pointerReg_read:
			begin
			 i2c_addr <= 3;
			 in_data <= CONVERSION_REG;
			 i2c_wr <= 1;
			 state<= state_wait1;
			 //CNT <= 9;
			end 
			
			state_stop2:
			begin
			   i2c_addr <= 1;
			   i2c_wr <= 1;
			   state <= state_wait1;
			end  
			
			state_start_bit3:
			begin
			 i2c_addr <= 0;
			 i2c_wr <= 1;
			 state <= state_wait1;  
			end 
			
			
			state_slave_read:		//11 send slave_addr + 1 to indicate its a read operation
			begin
				i2c_addr <= 3;
				in_data <= SLAVE_ADDR_RD;
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 10;
			end
			
			state_read_data1:		//12 i2c_addr = 2, cs, wr=1, so the FSM of i2c_master is in read state
			begin
				i2c_addr <= 2;
				in_data <= 1;
				i2c_wr <= 1;
				state <= state_wait1; 
				//CNT <= 11;
			end
		
			state_config_output1:		//13 i2c_addr = 3, cs,rd = 1, so out_data outputs from buffer(which is data from the corresponding register)
			begin
				i2c_addr <= 3;
				i2c_rd <= 1;
				state <= state_read_temp1;
			end
			
			state_read_temp1: 	//14 output 8 bit MSB data, depends on the configure register, the selected chanel temperature is output
			begin
				i2c_rd <= 0;
				state <= state_read_data2;
				case(channelCNT)
				  0:
				  chA_temp[15:8] <= out_data;
				  1:
				  chB_temp[15:8] <= out_data;
				  2:
				  chC_temp[15:8] <= out_data;
				  3:
				  chD_temp[15:8] <= out_data;	
				  default:
				  chA_temp[15:8] <= out_data;
				endcase
			end
			
			state_read_data2:		//15
			begin
				i2c_addr <= 2;
				in_data <= 1;
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 12;
			end	
	
			state_config_output2: 		//16
			begin
				i2c_addr <= 3;
				i2c_rd <= 1;
				state <= state_read_temp2;
			end
			
			state_read_temp2: 	//17 output LSB 8 bit data 
			begin
				i2c_rd <= 0;
				state <= state_stop3;
				case(channelCNT)
				  0:
				  chA_temp[7:0] <= out_data;
				  1:
				  chB_temp[7:0] <= out_data;
				  2:
				  chC_temp[7:0] <= out_data;
				  3:
				  chD_temp[7:0] <= out_data;	
				  default:
				  chA_temp[7:0] <= out_data;
				endcase
			end
				
			state_stop3: 		//18 send a stop bit to stop i2c
			begin
				i2c_addr <= 1;
				i2c_wr <= 1;
				state <= state_wait1;
				//CNT <= 13;
			end
      
      state_done:   //19
      begin
        case(channelCNT)
          0:
          begin
            channelCNT <= 1;
            state <= state_start_bit;
          end
          1:
          begin
            channelCNT <= 2;
            state <= state_start_bit;
          end
          2:
          begin
            channelCNT <= 3;
            state <= state_start_bit;
          end
          3:
          begin
            state <= state_idle;
            rdy <= 1;
          end
          default:
          state <= state_start_bit;
       endcase 
      end
		endcase
	end
end
		
						

//////////////////////chipscope//////////////////////////////
/*
wire [7:0] ila_trig = {6'b0,rdy,request};

wire [63:0] ila_data;
assign ila_data[15:0] = {5'b0,i2c_addr,2'b0,state};
assign ila_data[31:16] ={out_data,in_data} ;
assign ila_data[47:32] = {9'b0,channelCNT,CNT};

assign ila_data[63] = rdy; 
assign ila_data[62] = SCL;
assign ila_data[61] = SDA;
assign ila_data[60] = i2c_cs;
assign ila_data[59] = i2c_rd;
assign ila_data[58] = i2c_wr;


ila_trig8 ila_trig8_inst (
    .CONTROL(ila_CONTROL0), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(ila_trig), // IN BUS [7:0]
	 .DATA(ila_data) // IN BUS [63:0]
);
*/
			
endmodule