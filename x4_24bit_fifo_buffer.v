`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Shengli Liu, modified from X4_24bitfifo_buffer.v, VV.
// Description: circular buffer to keep looping all 4 channel ADC data. 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module x4_Channel_buffer(
    input [15:0] DINA,
    input [15:0] DINB,
	 input [15:0] DINC,
	 input [15:0] DIND,

    input WRCLK,
    input RDCLK,

    input WENBL,
	 input RENBL,

	 output [15:0] DOUTA,
	 output [15:0] DOUTB,
	 output [15:0] DOUTC,
	 output [15:0] DOUTD
    );

reg [8:0] sp_adr = 0;


  BUFGMUX #(
      .CLK_SEL_TYPE("SYNC")  // Glitchles ("SYNC") or fast ("ASYNC") clock switch-over
   )
   BUFGMUX_inst (
      .O(fifo_clk),  		 // 1-bit output: Clock buffer output
      .I0(RDCLK), 			 // 1-bit input: Clock buffer input (S=0)
      .I1(WRCLK), 		    // 1-bit input: Clock buffer input (S=1)
      .S(WENBL)    		    // 1-bit input: Clock buffer select
   );

fifobuf Buffer_ChA (
  .a(sp_adr), 						// input [11 : 0] a
  .d(DINA), 							// input [23 : 0] d
  .clk(fifo_clk), 					// input clk
  .we(WENBL), 							// input we
  .spo(DOUTA) 						   // output [23 : 0] qspo
);

fifobuf Buffer_ChB (
  .a(sp_adr), 						// input [11 : 0] a
  .d(DINB), 							// input [23 : 0] d
  .clk(fifo_clk), 					// input clk
  .we(WENBL), 							// input we
  .spo(DOUTB) 						   // output [23 : 0] qspo
);

fifobuf Buffer_ChC (
  .a(sp_adr), 						// input [11 : 0] a
  .d(DINC), 							// input [23 : 0] d
  .clk(fifo_clk), 					// input clk
  .we(WENBL), 							// input we
  .spo(DOUTC) 						   // output [23 : 0] qspo
);

fifobuf Buffer_ChD (
  .a(sp_adr), 						// input [11 : 0] a
  .d(DIND), 							// input [23 : 0] d
  .clk(fifo_clk), 					// input clk
  .we(WENBL), 							// input we
  .spo(DOUTD) 						   // output [23 : 0] qspo
);

always @ (posedge fifo_clk)		
begin
	if( WENBL == 1'b1) sp_adr <= sp_adr + 1;
	else if(RENBL == 1'b1) 	sp_adr <= sp_adr + 1;	
end


endmodule
