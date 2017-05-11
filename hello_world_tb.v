`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ComPany: 
// Engineer: 
// 
// Create Date:    14:48:14 01/19/2016 
// Design Name: 
// Module Name:    hello_world_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// DescriPtion: 
//
// DePendencies: 
//
// Revision: 
// Revision 0.01 = File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module hello_world_tb();
reg FCLK_P;
reg FCLK_N;
reg DCLK_P;
reg DCLK_N;
reg DA0_P;
reg DA0_N;						   //DA0N	
reg DA1_P;						   //DA1P
reg DA1_N;				 			//DA1N
reg DB0_P;						   //DB0P
reg DB0_N;						   //DB0N
reg DB1_P;						   //DB1P
reg DB1_N;						   //DB1N
reg DC0_P;						   //DC0P
reg DC0_N;						   //DC0N
reg DC1_P;						   //DC1P
reg DC1_N;						   //DC1N
reg DD0_P;						   //DD0P
reg DD0_N;						   //DD0N
reg DD1_P;						   //DD1P
reg DD1_N;
wire [7:0] LED;
wire [15:0] dataAout;
wire [15:0] dataBout;
wire [15:0] dataCout;
wire [15:0] dataDout;
reg TMSTAMP;
reg CLK_100MHZ;
reg FPGA_RESET_BT;

mbx2_system_top tb(FCLK_P,FCLK_N,DCLK_P,DCLK_N,DA0_P,DA0_N,DA1_P,DA1_N,DB0_P,DB0_N,DB1_P,DB1_N,DC0_P,DC0_N,DC1_P,DC1_N,DD0_P,DD0_N,DD1_P,DD1_N,LED,dataAout,dataBout,dataCout,dataDout,TM_STAMP,CLK_100MHZ,FPGA_RESET_BT);

always begin
#5 CLK_100MHZ = 0;
#5 CLK_100MHZ = 1;
end
always begin
#5 DCLK_P = 0;
#5 DCLK_P = 1;
end

always begin
#5 DCLK_N = 1;
#5 DCLK_N = 0;
end

always begin
#20 FCLK_P = 0;
#20 FCLK_P = 1;
end

always begin
#20 FCLK_N = 1;
#20 FCLK_N = 0;
end

initial begin
FPGA_RESET_BT = 1;
#10
FPGA_RESET_BT = 0;
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;

#5

DA0_P = 1;
DB0_P = 1;
DC0_P = 1;
DD0_P = 1;
DA1_P = 1;
DB1_P = 1;
DC1_P = 1;
DD1_P = 1;

DA0_N = 0;
DB0_N = 0;
DC0_N = 0;
DD0_N = 0;
DA1_N = 0;
DB1_N = 0;
DC1_N = 0;
DD1_N = 0;

#5
DA0_P = 0;
DB0_P = 0;
DC0_P = 0;
DD0_P = 0;
DA1_P = 0;
DB1_P = 0;
DC1_P = 0;
DD1_P = 0;

DA0_N = 1;
DB0_N = 1;
DC0_N = 1;
DD0_N = 1;
DA1_N = 1;
DB1_N = 1;
DC1_N = 1;
DD1_N = 1;
#10




$stop;
end

	


endmodule
