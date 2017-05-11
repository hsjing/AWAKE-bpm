`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:30 03/07/2016 
// Design Name: 
// Module Name:    top_testbench 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Dessdfcription: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_testbench();

parameter  	ADC_BIT_WIDTH = 16;
parameter  	SF_WIDTH = 32;

reg [4*ADC_BIT_WIDTH-1:0] ADC_data;

reg gclk0,clk;
reg rst;
/*
 wire [SF_WIDTH-1:0] ChA_Energy;
 wire [SF_WIDTH-1:0] ChB_Energy;
 wire [SF_WIDTH-1:0] ChC_Energy;
 wire [SF_WIDTH-1:0] ChD_Energy;


Buf_SigProcs Buf_SigProcs_inst(
.data_in(ADC_data),	//data from deserializer
.gclk0(gclk0),   //ADC data clk, 100MHz ~ 125 MHz
.clk(clk),     //slow processing clk, 1MHz ~ 10 MHz
	
.MB_bus_Clk(), 
.fast_fifo_rd(),
.fast_fifo_word(),
.fast_fifo_dout(),
	
.rst(rst),
.ex_trig(ex_trig),

.Trig_TH_Reg(16'd200),  //trigger threshold
.Trig_DT_Reg(16'd500),  //trigger dead time
.Evt_Len_Reg(16'd400),  //Event Length in samples reg
.Evt_Tail_Len_Reg(16'd300),  //Event tail length in samples reg

.control_reg(16'h0),
.status_net(),

.ChA_Energy_reg(ChA_Energy),
.ChB_Energy_reg(ChB_Energy),
.ChC_Energy_reg(ChC_Energy),
.ChD_Energy_reg(ChD_Energy),

.busy(busy) //to prevent the Fast fifo to be readout by MB

);

*/

reg enable_pulse_gen;
wire [15:0] db;


pulse_gen U_pulse_gen (
         .dclk(glck0),
         .reset(rst),
         .enable(enable_pulse_gen),
         .db(db));

//ADC data gclk0 100MHz generation
always begin
#5 gclk0 <= 0;
#5 gclk0 <= 1;
end

//slow clk 10MHz generation
always begin
#50 clk <= 0;
#50 clk <= 1;
end

/////////////////////////////////////////
//test start here

initial begin
	rst <= 1;
	enable_pulse_gen <= 0;
	#110
	rst <= 0;

	#20
	enable_pulse_gen <= 1;

	#1000;
		
end //intital 

endmodule

/*
always@ (posedge gclk0)begin
	if(rst)begin
		sum <= 0;
		index <= 0;
	end
	else begin
	if(rd == 1) begin
		index <= index + 1;
		datain <= db;
		array[index] <= db;
		
		if(CNT >= 1)begin
			enable_pulse_gen <= 0;
			CNT <= 0;
		end
		else begin
			enable_pulse_gen <= 1;
			CNT <= CNT + 1;
		end
	end
	end
end

endmodule
*/


/*
initial begin
CNT <= 0;
N <= 68;
rst <= 1;
start <= 0;
start_file_wr <= 0;
#20

rst <= 0;
enable_pulse_gen <= 0;

f = $fopen("data.txt","w");
#20
start_file_wr <=1;
#20

#20
start <= 1;
enable_pulse_gen <= 1;

@(posedge rdy) begin
start <= 0;

for( i =0;i <= 255;) begin
 $fdisplay(f,"%d\n",array[i]); 
 i = i +1;
end

#1000
start_file_wr <= 0;
#1000
$fclose(f);
end
end
*/

