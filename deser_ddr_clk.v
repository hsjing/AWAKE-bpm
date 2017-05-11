`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Victor Verzilov
// 
// Create Date:     7/11/2013 
// Design Name: 
// Module Name:    DDR clock for a 8-bit deserializer
// Project Name:   TRIUMF AWAKE BPM Electronics Module FPGA
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module deser_ddr_clk(
	 input DCLKP,				   // Data frame clock pos
	 input DCLKN,				   // Data frame clock neg	 
	// output BUFFCLK,				// Buffered frame clock
	 output BUFx1GCLK,			// Buffered global clock obtained by division of data clock by DESERF
 //   output BUFx2GCLK,			// Buffered x2 global clock 
	 output DESERSTROBE,			// Deserialization clock
    output BUFIODCLKP,			// Buffered high speed IO clock pos
    output BUFIODCLKN,			// Buffered high speed IO clock neg
	 input RESET
    );

    parameter integer 	DESERF = 8;
    parameter integer 	HALFDESERF = 4;
	 parameter integer	CLKDLY = 0;


   IBUFDS_DIFF_OUT #(
      .DIFF_TERM("FALSE"),          // Differential Termination, "TRUE"/"FALSE" 
      .IOSTANDARD("DEFAULT")        // Specify the input I/O standard
   ) IBUFDS_dclk (
      .O(dclk_in_p),                // Buffer diff_p output
      .OB(dclk_in_n),               // Buffer diff_n output
      .I(DCLKP),                    // Diff_p buffer input (connect directly to top-level port)
      .IB(DCLKN)                    // Diff_n buffer input (connect directly to top-level port)
   );

   IODELAY2 #(
      .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), // "STAY_AT_LIMIT" or "WRAPAROUND" 
      .DATA_RATE("SDR"),                    // "SDR" or "DDR" 
      .DELAY_SRC("IDATAIN"),                // "IO", "ODATAIN" or "IDATAIN" 
      .IDELAY2_VALUE(0),                    // Delay value when IDELAY_MODE="PCI" (0-255)
      .IDELAY_MODE("NORMAL"),               // "NORMAL" or "PCI" 
      .IDELAY_TYPE("FIXED"),                // "FIXED", "DEFAULT", "VARIABLE_FROM_ZERO", "VARIABLE_FROM_HALF_MAX" 
                                            // or "DIFF_PHASE_DETECTOR" 
      .IDELAY_VALUE(CLKDLY),               // Amount of taps for fixed input delay (0-255)
      .ODELAY_VALUE(0),                     // Amount of taps fixed output delay (0-255)
      .SERDES_MODE("MASTER"),               // "NONE", "MASTER" or "SLAVE" 
      .SIM_TAPDELAY_VALUE(49)               // Per tap delay used for simulation in ps
   )
   IODELAY2_dclk_dly_p (
      .BUSY(),                           // 1-bit output: Busy output after CAL
      .DATAOUT(dclk_dly_p),              // 1-bit output: Delayed data output to ISERDES/input register
      .DATAOUT2(),                       // 1-bit output: Delayed data output to general FPGA fabric
      .DOUT(),                           // 1-bit output: Delayed data output
      .TOUT(),                           // 1-bit output: Delayed 3-state output
      .CAL(1'b0),                        // 1-bit input: Initiate calibration input
      .CE(1'b0),                         // 1-bit input: Enable INC input
      .CLK(1'b0),                        // 1-bit input: Clock input
      .IDATAIN(dclk_in_p),               // 1-bit input: Data input (connect to top-level port or I/O buffer)
      .INC(1'b0),                        // 1-bit input: Increment / decrement input
      .IOCLK0(1'b0),                     // 1-bit input: Input from the I/O clock network
      .IOCLK1(1'b0),                     // 1-bit input: Input from the I/O clock network
      .ODATAIN(1'b0),                    // 1-bit input: Output data input from output register or OSERDES2.
      .RST(1'b0),                        // 1-bit input: Reset to zero or 1/2 of total delay period
      .T(1'b1)                           // 1-bit input: 3-state input signal
   );

   IODELAY2 #(
      .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), // "STAY_AT_LIMIT" or "WRAPAROUND" 
      .DATA_RATE("SDR"),                    // "SDR" or "DDR" 
      .DELAY_SRC("IDATAIN"),                // "IO", "ODATAIN" or "IDATAIN" 
      .IDELAY2_VALUE(0),                    // Delay value when IDELAY_MODE="PCI" (0-255)
      .IDELAY_MODE("NORMAL"),               // "NORMAL" or "PCI" 
      .IDELAY_TYPE("FIXED"),                // "FIXED", "DEFAULT", "VARIABLE_FROM_ZERO", "VARIABLE_FROM_HALF_MAX" 
                                            // or "DIFF_PHASE_DETECTOR" 
      .IDELAY_VALUE(CLKDLY),               // Amount of taps for fixed input delay (0-255)
      .ODELAY_VALUE(0),                     // Amount of taps fixed output delay (0-255)
      .SERDES_MODE("SLAVE"),                // "NONE", "MASTER" or "SLAVE" 
      .SIM_TAPDELAY_VALUE(49)               // Per tap delay used for simulation in ps
   )
   IODELAY2_dclk_dly_n (
      .BUSY(),                           // 1-bit output: Busy output after CAL
      .DATAOUT(dclk_dly_n),              // 1-bit output: Delayed data output to ISERDES/input register
      .DATAOUT2(),                       // 1-bit output: Delayed data output to general FPGA fabric
      .DOUT(),                           // 1-bit output: Delayed data output
      .TOUT(),                           // 1-bit output: Delayed 3-state output
      .CAL(1'b0),                        // 1-bit input: Initiate calibration input
      .CE(1'b0),                         // 1-bit input: Enable INC input
      .CLK(1'b0),                        // 1-bit input: Clock input
      .IDATAIN(dclk_in_n),               // 1-bit input: Data input (connect to top-level port or I/O buffer)
      .INC(1'b0),                        // 1-bit input: Increment / decrement input
      .IOCLK0(1'b0),                     // 1-bit input: Input from the I/O clock network
      .IOCLK1(1'b0),                     // 1-bit input: Input from the I/O clock network
      .ODATAIN(1'b0),                    // 1-bit input: Output data input from output register or OSERDES2.
      .RST(1'b0),                        // 1-bit input: Reset to zero or 1/2 of total delay period
      .T(1'b1)                           // 1-bit input: 3-state input signal
   );				

   BUFIO2_2CLK #(
      .DIVIDE(DESERF)  // DIVCLK divider (1-8)
   )
   BUFIO_2CLK_dclkp (
      .DIVCLK(x1GCLK),                         // 1-bit output: Divided clock output
      .IOCLK(BUFIODCLKP),                      // 1-bit output: I/O output clock
      .SERDESSTROBE(DESERSTROBE),              // 1-bit output: Output SERDES strobe (connect to ISERDES2/OSERDES2)
      .I(dclk_dly_p),                          // 1-bit input: Clock input (connect to IBUFG)
      .IB(dclk_dly_n)                          // 1-bit input: Secondary clock input
   );

   BUFG BUFG_fdclk (
      .O(BUFx1GCLK),                     // 1-bit output: Clock buffer output
      .I(x1GCLK)                         // 1-bit input: Clock buffer input
   );

   BUFIO2 #(
      .DIVIDE_BYPASS("FALSE"), // Bypass the divider circuitry (TRUE/FALSE)
      .DIVIDE(HALFDESERF),     // DIVCLK divider (1-8)
      .I_INVERT("FALSE"),      // Invert clock (TRUE/FALSE)
      .USE_DOUBLER("FALSE")    // Use doubler circuitry (TRUE/FALSE)
   )
   BUFIO2_dclkn (
      .DIVCLK(x2GCLK),          // 1-bit output: Divided clock output
      .IOCLK(BUFIODCLKN),       // 1-bit output: I/O output clock
      .SERDESSTROBE(),          // 1-bit output: Output SERDES strobe (connect to ISERDES2/OSERDES2)
      .I(dclk_dly_n)            // 1-bit input: Clock input (connect to IBUFG)
   );

 /*  BUFG BUFG_gclk (
      .O(BUFx2GCLK),            // 1-bit output: Clock buffer output
      .I(x2GCLK)                // 1-bit input: Clock buffer input
   );*/
   

endmodule