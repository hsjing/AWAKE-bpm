//-----------------------------------------------------------------------------
// mb_system_tb.v
//-----------------------------------------------------------------------------

`timescale 1 ps / 100 fs

`uselib lib=unisims_ver

// START USER CODE (Do not remove this line)

// User: Put your directives here. Code in this
//       section will not be overwritten.

// END USER CODE (Do not remove this line)

module mb_system_tb
  (
  );

  // START USER CODE (Do not remove this line)

  // User: Put your signals here. Code in this
  //       section will not be overwritten.

  // END USER CODE (Do not remove this line)

  real CLK_PERIOD = 10000.000000;
  real RESET_LENGTH = 160000;

  // Internal signals

  reg CLK;
  reg [7:0] DIP_Switches_8Bits_TRI_I;
  reg Ethernet_Lite_COL;
  reg Ethernet_Lite_CRS;
  wire Ethernet_Lite_MDC;
  wire Ethernet_Lite_MDIO;
  wire Ethernet_Lite_PHY_RST_N;
  reg [3:0] Ethernet_Lite_RXD;
  reg Ethernet_Lite_RX_CLK;
  reg Ethernet_Lite_RX_DV;
  reg Ethernet_Lite_RX_ER;
  wire [3:0] Ethernet_Lite_TXD;
  reg Ethernet_Lite_TX_CLK;
  wire Ethernet_Lite_TX_EN;
  wire [7:0] LEDs_8Bits_TRI_O;
  wire [0:23] Linear_Flash_address;
  wire Linear_Flash_ce_n;
  wire [0:15] Linear_Flash_data;
  wire Linear_Flash_oe_n;
  wire Linear_Flash_reset;
  wire Linear_Flash_we_n;
  reg [2:0] Push_Buttons_3Bits_TRI_I;
  reg RESET;
  reg RS232_USB_sin;
  wire RS232_USB_sout;
  reg RS232_sin;
  wire RS232_sout;
  wire [31:0] axi_bram_ctrl_0_BRAM_Addr_A_pin;
  wire axi_bram_ctrl_0_BRAM_Clk_A_pin;
  wire axi_bram_ctrl_0_BRAM_En_A_pin;
  reg [31:0] axi_bram_ctrl_0_BRAM_RdData_A_pin;
  wire axi_bram_ctrl_0_BRAM_Rst_A_pin;
  wire [3:0] axi_bram_ctrl_0_BRAM_WE_A_pin;
  wire [31:0] axi_bram_ctrl_0_BRAM_WrData_A_pin;
  wire [12:0] mcbx_dram_addr;
  wire [2:0] mcbx_dram_ba;
  wire mcbx_dram_cas_n;
  wire mcbx_dram_cke;
  wire mcbx_dram_clk;
  wire mcbx_dram_clk_n;
  wire mcbx_dram_ddr3_rst;
  wire [15:0] mcbx_dram_dq;
  wire mcbx_dram_dqs;
  wire mcbx_dram_dqs_n;
  wire mcbx_dram_ldm;
  wire mcbx_dram_odt;
  wire mcbx_dram_ras_n;
  wire mcbx_dram_udm;
  wire mcbx_dram_udqs;
  wire mcbx_dram_udqs_n;
  wire mcbx_dram_we_n;
  wire rzq;
  wire zio;

  mb_system
    dut (
      .zio ( zio ),
      .rzq ( rzq ),
      .mcbx_dram_we_n ( mcbx_dram_we_n ),
      .mcbx_dram_udqs_n ( mcbx_dram_udqs_n ),
      .mcbx_dram_udqs ( mcbx_dram_udqs ),
      .mcbx_dram_udm ( mcbx_dram_udm ),
      .mcbx_dram_ras_n ( mcbx_dram_ras_n ),
      .mcbx_dram_odt ( mcbx_dram_odt ),
      .mcbx_dram_ldm ( mcbx_dram_ldm ),
      .mcbx_dram_dqs_n ( mcbx_dram_dqs_n ),
      .mcbx_dram_dqs ( mcbx_dram_dqs ),
      .mcbx_dram_dq ( mcbx_dram_dq ),
      .mcbx_dram_ddr3_rst ( mcbx_dram_ddr3_rst ),
      .mcbx_dram_clk_n ( mcbx_dram_clk_n ),
      .mcbx_dram_clk ( mcbx_dram_clk ),
      .mcbx_dram_cke ( mcbx_dram_cke ),
      .mcbx_dram_cas_n ( mcbx_dram_cas_n ),
      .mcbx_dram_ba ( mcbx_dram_ba ),
      .mcbx_dram_addr ( mcbx_dram_addr ),
      .RS232_sout ( RS232_sout ),
      .RS232_sin ( RS232_sin ),
      .RS232_USB_sout ( RS232_USB_sout ),
      .RS232_USB_sin ( RS232_USB_sin ),
      .RESET ( RESET ),
      .Push_Buttons_3Bits_TRI_I ( Push_Buttons_3Bits_TRI_I ),
      .Linear_Flash_we_n ( Linear_Flash_we_n ),
      .Linear_Flash_reset ( Linear_Flash_reset ),
      .Linear_Flash_oe_n ( Linear_Flash_oe_n ),
      .Linear_Flash_data ( Linear_Flash_data ),
      .Linear_Flash_ce_n ( Linear_Flash_ce_n ),
      .Linear_Flash_address ( Linear_Flash_address ),
      .LEDs_8Bits_TRI_O ( LEDs_8Bits_TRI_O ),
      .Ethernet_Lite_TX_EN ( Ethernet_Lite_TX_EN ),
      .Ethernet_Lite_TX_CLK ( Ethernet_Lite_TX_CLK ),
      .Ethernet_Lite_TXD ( Ethernet_Lite_TXD ),
      .Ethernet_Lite_RX_ER ( Ethernet_Lite_RX_ER ),
      .Ethernet_Lite_RX_DV ( Ethernet_Lite_RX_DV ),
      .Ethernet_Lite_RX_CLK ( Ethernet_Lite_RX_CLK ),
      .Ethernet_Lite_RXD ( Ethernet_Lite_RXD ),
      .Ethernet_Lite_PHY_RST_N ( Ethernet_Lite_PHY_RST_N ),
      .Ethernet_Lite_MDIO ( Ethernet_Lite_MDIO ),
      .Ethernet_Lite_MDC ( Ethernet_Lite_MDC ),
      .Ethernet_Lite_CRS ( Ethernet_Lite_CRS ),
      .Ethernet_Lite_COL ( Ethernet_Lite_COL ),
      .DIP_Switches_8Bits_TRI_I ( DIP_Switches_8Bits_TRI_I ),
      .CLK ( CLK ),
      .axi_bram_ctrl_0_BRAM_Rst_A_pin ( axi_bram_ctrl_0_BRAM_Rst_A_pin ),
      .axi_bram_ctrl_0_BRAM_Clk_A_pin ( axi_bram_ctrl_0_BRAM_Clk_A_pin ),
      .axi_bram_ctrl_0_BRAM_WrData_A_pin ( axi_bram_ctrl_0_BRAM_WrData_A_pin ),
      .axi_bram_ctrl_0_BRAM_Addr_A_pin ( axi_bram_ctrl_0_BRAM_Addr_A_pin ),
      .axi_bram_ctrl_0_BRAM_RdData_A_pin ( axi_bram_ctrl_0_BRAM_RdData_A_pin ),
      .axi_bram_ctrl_0_BRAM_En_A_pin ( axi_bram_ctrl_0_BRAM_En_A_pin ),
      .axi_bram_ctrl_0_BRAM_WE_A_pin ( axi_bram_ctrl_0_BRAM_WE_A_pin )
    );

  // Clock generator for CLK

  initial
    begin
      CLK = 1'b0;
      forever #(CLK_PERIOD/2.00)
        CLK = ~CLK;
    end

  // Reset Generator for RESET

  initial
    begin
      RESET = 1'b1;
      #(RESET_LENGTH) RESET = ~RESET;
    end

  // START USER CODE (Do not remove this line)

  // User: Put your stimulus here. Code in this
  //       section will not be overwritten.

  // END USER CODE (Do not remove this line)

endmodule

