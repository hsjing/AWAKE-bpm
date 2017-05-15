//-----------------------------------------------------------------------------
// mb_system_stub.v
//-----------------------------------------------------------------------------

module mb_system_stub
  (
    zio,
    rzq,
    mcbx_dram_we_n,
    mcbx_dram_udqs_n,
    mcbx_dram_udqs,
    mcbx_dram_udm,
    mcbx_dram_ras_n,
    mcbx_dram_odt,
    mcbx_dram_ldm,
    mcbx_dram_dqs_n,
    mcbx_dram_dqs,
    mcbx_dram_dq,
    mcbx_dram_ddr3_rst,
    mcbx_dram_clk_n,
    mcbx_dram_clk,
    mcbx_dram_cke,
    mcbx_dram_cas_n,
    mcbx_dram_ba,
    mcbx_dram_addr,
    RS232_sout,
    RS232_sin,
    RS232_USB_sout,
    RS232_USB_sin,
    RESET,
    Push_Buttons_3Bits_TRI_I,
    Linear_Flash_we_n,
    Linear_Flash_reset,
    Linear_Flash_oe_n,
    Linear_Flash_data,
    Linear_Flash_ce_n,
    Linear_Flash_address,
    LEDs_8Bits_TRI_O,
    Ethernet_Lite_TX_EN,
    Ethernet_Lite_TX_CLK,
    Ethernet_Lite_TXD,
    Ethernet_Lite_RX_ER,
    Ethernet_Lite_RX_DV,
    Ethernet_Lite_RX_CLK,
    Ethernet_Lite_RXD,
    Ethernet_Lite_PHY_RST_N,
    Ethernet_Lite_MDIO,
    Ethernet_Lite_MDC,
    Ethernet_Lite_CRS,
    Ethernet_Lite_COL,
    DIP_Switches_8Bits_TRI_I,
    CLK,
    axi_bram_ctrl_0_BRAM_Rst_A_pin,
    axi_bram_ctrl_0_BRAM_Clk_A_pin,
    axi_bram_ctrl_0_BRAM_WrData_A_pin,
    axi_bram_ctrl_0_BRAM_Addr_A_pin,
    axi_bram_ctrl_0_BRAM_RdData_A_pin,
    axi_bram_ctrl_0_BRAM_En_A_pin,
    axi_bram_ctrl_0_BRAM_WE_A_pin
  );
  inout zio;
  inout rzq;
  output mcbx_dram_we_n;
  inout mcbx_dram_udqs_n;
  inout mcbx_dram_udqs;
  output mcbx_dram_udm;
  output mcbx_dram_ras_n;
  output mcbx_dram_odt;
  output mcbx_dram_ldm;
  inout mcbx_dram_dqs_n;
  inout mcbx_dram_dqs;
  inout [15:0] mcbx_dram_dq;
  output mcbx_dram_ddr3_rst;
  output mcbx_dram_clk_n;
  output mcbx_dram_clk;
  output mcbx_dram_cke;
  output mcbx_dram_cas_n;
  output [2:0] mcbx_dram_ba;
  output [12:0] mcbx_dram_addr;
  output RS232_sout;
  input RS232_sin;
  output RS232_USB_sout;
  input RS232_USB_sin;
  input RESET;
  input [2:0] Push_Buttons_3Bits_TRI_I;
  output Linear_Flash_we_n;
  output Linear_Flash_reset;
  output Linear_Flash_oe_n;
  inout [0:15] Linear_Flash_data;
  output Linear_Flash_ce_n;
  output [0:23] Linear_Flash_address;
  output [7:0] LEDs_8Bits_TRI_O;
  output Ethernet_Lite_TX_EN;
  (* BUFFER_TYPE = "IBUF" *)
  input Ethernet_Lite_TX_CLK;
  output [3:0] Ethernet_Lite_TXD;
  input Ethernet_Lite_RX_ER;
  input Ethernet_Lite_RX_DV;
  (* BUFFER_TYPE = "IBUF" *)
  input Ethernet_Lite_RX_CLK;
  input [3:0] Ethernet_Lite_RXD;
  output Ethernet_Lite_PHY_RST_N;
  inout Ethernet_Lite_MDIO;
  output Ethernet_Lite_MDC;
  input Ethernet_Lite_CRS;
  input Ethernet_Lite_COL;
  input [7:0] DIP_Switches_8Bits_TRI_I;
  input CLK;
  output axi_bram_ctrl_0_BRAM_Rst_A_pin;
  output axi_bram_ctrl_0_BRAM_Clk_A_pin;
  output [31:0] axi_bram_ctrl_0_BRAM_WrData_A_pin;
  output [31:0] axi_bram_ctrl_0_BRAM_Addr_A_pin;
  input [31:0] axi_bram_ctrl_0_BRAM_RdData_A_pin;
  output axi_bram_ctrl_0_BRAM_En_A_pin;
  output [3:0] axi_bram_ctrl_0_BRAM_WE_A_pin;

  (* BOX_TYPE = "user_black_box" *)
  mb_system
    mb_system_i (
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

endmodule

