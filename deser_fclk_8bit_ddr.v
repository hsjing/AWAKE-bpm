`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Victor Verzilov
// 
// Create Date:     10/05/2012 
// Design Name: 
// Module Name:    8bit single channel deserializer 
// Project Name:   TRIUMF AWAKE BPM Electronics Module FPGA
// Target Devices: 
// Tool versions: 
// Description:    Deserialize ADC FCLK signal and use it for frame synchronization 
//
// Dependencies: 
//
// Revision: 
// 10/05/2012 Revision 0.01 - File Created
// 14/11/2013 Revision 1.0  - Converted to differential DDR clock
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module deser_fclk_8bit_ddr( 
	 input DATAP,			                
	 input DATAN,			                
	 input IOCLKP,
	 input IOCLKN,
	 input GCLK,
    input IOSTROBE,	
	 output [7:0] DATAOUT,
	 input RESET,
	 input DESERSYNC,
	 output BTSLP,
	 output DEBUG
    );

    parameter integer 	DESERF = 8;
	 parameter integer 	SIM_TAP_DELAY = 75;
	 parameter integer 	IDELAY_VALUE = 0;
	 parameter integer	ADC_SYNC_PATTERN =8'hF0;		//11110000 test pattern
	 

	 reg state;
	 reg [3:0] count_gclk = 4'b0000;
	 reg bitslip = 0;
	 reg sync_ok;
//	 reg [7:0] DATAOUT;

//  Perform bit alignment according to ADC SYNC pattern MSB 0xF0 LSB

always @ (posedge GCLK)		
begin
		if (RESET == 1'b1) begin
			 state <= 0;
			 bitslip <= 1'b0;
			 count_gclk <= 4'b0000;			
		end
	   else if (DESERSYNC == 1'b1) begin					
			if (state == 0) begin
				if (DATAOUT[7:0] != ADC_SYNC_PATTERN) begin	
					sync_ok <= 1'b1;				
     	   		bitslip <= 1'b1;									// Request bitslip, shift the data until it matches the sync pattern:11110000
     	   		state <= 1;
     	   		count_gclk <= 4'b0000;							// Reset wait counter
    	   	end
			   else begin
					sync_ok <= 1'b0;
				end
			end
   	   else if (state == 1) begin
				bitslip <= 1'b0;										// Reset bitslip
     	   	count_gclk <= count_gclk + 4'b0001; 			// Wait for 16 global clock cycles before repeating 
				if (count_gclk == 4'b1111) begin
     	   		state <= 0;
				end	
     	   end
     	end
end

assign BTSLP = bitslip;
assign DEBUG = sync_ok;
//////////////////////////////////////////////////////////////	 
	 

   IBUFGDS #(
      .DIFF_TERM("TRUE"),   		        // Differential Termination
      .IOSTANDARD("LVDS_25") 		        // Specify the input I/O standard
   ) IBUFGDS_data (
      .O(data_in), 		                 // Clock buffer output
      .I(DATAP),  			              // Diff_p buffer input (connect directly to top-level port)
      .IB(DATAN) 			                 // Diff_n buffer input (connect directly to top-level port)
   );
	
   IODELAY2 #(
      .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), // "STAY_AT_LIMIT" or "WRAPAROUND" 
      .DATA_RATE("DDR"),                    // "SDR" or "DDR" 
      .DELAY_SRC("IDATAIN"),                // "IO", "ODATAIN" or "IDATAIN" 
      .IDELAY2_VALUE(0),                    // Delay value when IDELAY_MODE="PCI" (0-255)
      .IDELAY_MODE("NORMAL"),               // "NORMAL" or "PCI" 
      .IDELAY_TYPE("FIXED"),                // "FIXED", "DEFAULT", "VARIABLE_FROM_ZERO", "VARIABLE_FROM_HALF_MAX" 
                                            // or "DIFF_PHASE_DETECTOR" 
      .IDELAY_VALUE(IDELAY_VALUE),          // Amount of taps for fixed input delay (0-255)
      .ODELAY_VALUE(0),                     // Amount of taps fixed output delay (0-255)
      .SERDES_MODE("NONE"),                 // "NONE", "MASTER" or "SLAVE" 
      .SIM_TAPDELAY_VALUE(SIM_TAP_DELAY)               // Per tap delay used for simulation in ps
   )
   IODELAY2_da0 (
      .BUSY(),                              // 1-bit output: Busy output after CAL
      .DATAOUT(data_dly_iob),               // 1-bit output: Delayed data output to ISERDES/input register
      .DATAOUT2(),                          // 1-bit output: Delayed data output to general FPGA fabric
      .DOUT(),                              // 1-bit output: Delayed data output
      .TOUT(),                              // 1-bit output: Delayed 3-state output
      .CAL(1'b0),                           // 1-bit input: Initiate calibration input
      .CE(1'b0),                            // 1-bit input: Enable INC input
      .CLK(),                               // 1-bit input: Clock input
      .IDATAIN(data_in),                    // 1-bit input: Data input (connect to top-level port or I/O buffer)
      .INC(1'b0),                           // 1-bit input: Increment / decrement input
      .IOCLK0(),                            // 1-bit input: Input from the I/O clock network
      .IOCLK1(1'b0),                        // 1-bit input: Input from the I/O clock network
      .ODATAIN(1'b0),                       // 1-bit input: Output data input from output register or OSERDES2.
      .RST(RESET),                          // 1-bit input: Reset to zero or 1/2 of total delay period
      .T(1'b1)                              // 1-bit input: 3-state input signal
   );

   ISERDES2 #(
      .BITSLIP_ENABLE("TRUE"),           // Enable Bitslip Functionality (TRUE/FALSE)
      .DATA_RATE("DDR"),                 // Data-rate ("SDR" or "DDR")
      .DATA_WIDTH(DESERF),               // Parallel data width selection (2-8)
      .INTERFACE_TYPE("RETIMED"),        // "NETWORKING", "NETWORKING_PIPELINED" or "RETIMED" 
      .SERDES_MODE("MASTER")             // "NONE", "MASTER" or "SLAVE" 
   )
   ISERDES2_mstr (
      .CFB0(),                           // 1-bit output: Clock feed-through route output
      .CFB1(),                           // 1-bit output: Clock feed-through route output
      .DFB(),                            // 1-bit output: Feed-through clock output
      .FABRICOUT(),                      // 1-bit output: Unsynchrnonized data output
      .INCDEC(),                         // 1-bit output: Phase detector output
                                         // Q1 - Q4: 1-bit (each) output: Registered outputs to FPGA logic
      .Q1(DATAOUT[3]),
      .Q2(DATAOUT[2]),
      .Q3(DATAOUT[1]),
      .Q4(DATAOUT[0]),
      .SHIFTOUT(mstr2slv),               // 1-bit output: Cascade output signal for master/slave I/O
      .VALID(),                          // 1-bit output: Output status of the phase detector
      .BITSLIP(bitslip),                 // 1-bit input: Bitslip enable input
      .CE0(1'b1),                        // 1-bit input: Clock enable input
      .CLK0(IOCLKP),                      // 1-bit input: I/O clock network input
      .CLK1(IOCLKN),                       // 1-bit input: Secondary I/O clock network input
      .CLKDIV(GCLK),                     // 1-bit input: FPGA logic domain clock input
      .D(data_dly_iob),                  // 1-bit input: Input data
      .IOCE(IOSTROBE),                   // 1-bit input: Data strobe input
      .RST(RESET),                        // 1-bit input: Asynchronous reset input
      .SHIFTIN(1'b0)                     // 1-bit input: Cascade input signal for master/slave I/O
   );

  ISERDES2 #(
      .BITSLIP_ENABLE("TRUE"),           // Enable Bitslip Functionality (TRUE/FALSE)
      .DATA_RATE("DDR"),                 // Data-rate ("SDR" or "DDR")
      .DATA_WIDTH(DESERF),               // Parallel data width selection (2-8)
      .INTERFACE_TYPE("RETIMED"),        // "NETWORKING", "NETWORKING_PIPELINED" or "RETIMED" 
      .SERDES_MODE("SLAVE")              // "NONE", "MASTER" or "SLAVE" 
   )
   ISERDES2_slv (
      .CFB0(),                           // 1-bit output: Clock feed-through route output
      .CFB1(),                           // 1-bit output: Clock feed-through route output
      .DFB(),                            // 1-bit output: Feed-through clock output
      .FABRICOUT(),                      // 1-bit output: Unsynchrnonized data output
      .INCDEC(),                         // 1-bit output: Phase detector output
                                         // Q1 - Q4: 1-bit (each) output: Registered outputs to FPGA logic
      .Q1(DATAOUT[7]),
      .Q2(DATAOUT[6]),
      .Q3(DATAOUT[5]),
      .Q4(DATAOUT[4]),
      .SHIFTOUT(),                       // 1-bit output: Cascade output signal for master/slave I/O
      .VALID(),                          // 1-bit output: Output status of the phase detector
      .BITSLIP(bitslip),                 // 1-bit input: Bitslip enable input
      .CE0(1'b1),                        // 1-bit input: Clock enable input
      .CLK0(IOCLKP),                      // 1-bit input: I/O clock network input
      .CLK1(IOCLKN),                       // 1-bit input: Secondary I/O clock network input
      .CLKDIV(GCLK),                     // 1-bit input: FPGA logic domain clock input
      .D(),                              // 1-bit input: Input data
      .IOCE(IOSTROBE),                   // 1-bit input: Data strobe input
      .RST(RESET),                        // 1-bit input: Asynchronous reset input
      .SHIFTIN(mstr2slv)                 // 1-bit input: Cascade input signal for master/slave I/O
   );
	

endmodule