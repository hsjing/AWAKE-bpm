//-----------------------------------------------------------------------------
// mb_system.v
//-----------------------------------------------------------------------------

`timescale 1 ps / 100 fs

`uselib lib=unisims_ver

module mb_system
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
  input Ethernet_Lite_TX_CLK;
  output [3:0] Ethernet_Lite_TXD;
  input Ethernet_Lite_RX_ER;
  input Ethernet_Lite_RX_DV;
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

  // Internal signals

  wire Ethernet_Lite_IP2INTC_Irpt;
  wire Ethernet_Lite_MDIO_I;
  wire Ethernet_Lite_MDIO_O;
  wire Ethernet_Lite_MDIO_T;
  wire Ext_BRK;
  wire Ext_NM_BRK;
  wire [0:15] Linear_Flash_data_I;
  wire [0:15] Linear_Flash_data_O;
  wire [0:15] Linear_Flash_data_T;
  wire [31:0] axi4_0_M_ARADDR;
  wire [1:0] axi4_0_M_ARBURST;
  wire [3:0] axi4_0_M_ARCACHE;
  wire [0:0] axi4_0_M_ARESETN;
  wire [0:0] axi4_0_M_ARID;
  wire [7:0] axi4_0_M_ARLEN;
  wire [1:0] axi4_0_M_ARLOCK;
  wire [2:0] axi4_0_M_ARPROT;
  wire [3:0] axi4_0_M_ARQOS;
  wire [0:0] axi4_0_M_ARREADY;
  wire [2:0] axi4_0_M_ARSIZE;
  wire [0:0] axi4_0_M_ARVALID;
  wire [31:0] axi4_0_M_AWADDR;
  wire [1:0] axi4_0_M_AWBURST;
  wire [3:0] axi4_0_M_AWCACHE;
  wire [0:0] axi4_0_M_AWID;
  wire [7:0] axi4_0_M_AWLEN;
  wire [1:0] axi4_0_M_AWLOCK;
  wire [2:0] axi4_0_M_AWPROT;
  wire [3:0] axi4_0_M_AWQOS;
  wire [0:0] axi4_0_M_AWREADY;
  wire [2:0] axi4_0_M_AWSIZE;
  wire [0:0] axi4_0_M_AWVALID;
  wire [0:0] axi4_0_M_BID;
  wire [0:0] axi4_0_M_BREADY;
  wire [1:0] axi4_0_M_BRESP;
  wire [0:0] axi4_0_M_BVALID;
  wire [31:0] axi4_0_M_RDATA;
  wire [0:0] axi4_0_M_RID;
  wire [0:0] axi4_0_M_RLAST;
  wire [0:0] axi4_0_M_RREADY;
  wire [1:0] axi4_0_M_RRESP;
  wire [0:0] axi4_0_M_RVALID;
  wire [31:0] axi4_0_M_WDATA;
  wire [0:0] axi4_0_M_WLAST;
  wire [0:0] axi4_0_M_WREADY;
  wire [3:0] axi4_0_M_WSTRB;
  wire [0:0] axi4_0_M_WVALID;
  wire [63:0] axi4_0_S_ARADDR;
  wire [3:0] axi4_0_S_ARBURST;
  wire [7:0] axi4_0_S_ARCACHE;
  wire [1:0] axi4_0_S_ARID;
  wire [15:0] axi4_0_S_ARLEN;
  wire [3:0] axi4_0_S_ARLOCK;
  wire [5:0] axi4_0_S_ARPROT;
  wire [7:0] axi4_0_S_ARQOS;
  wire [1:0] axi4_0_S_ARREADY;
  wire [5:0] axi4_0_S_ARSIZE;
  wire [9:0] axi4_0_S_ARUSER;
  wire [1:0] axi4_0_S_ARVALID;
  wire [63:0] axi4_0_S_AWADDR;
  wire [3:0] axi4_0_S_AWBURST;
  wire [7:0] axi4_0_S_AWCACHE;
  wire [1:0] axi4_0_S_AWID;
  wire [15:0] axi4_0_S_AWLEN;
  wire [3:0] axi4_0_S_AWLOCK;
  wire [5:0] axi4_0_S_AWPROT;
  wire [7:0] axi4_0_S_AWQOS;
  wire [1:0] axi4_0_S_AWREADY;
  wire [5:0] axi4_0_S_AWSIZE;
  wire [9:0] axi4_0_S_AWUSER;
  wire [1:0] axi4_0_S_AWVALID;
  wire [1:0] axi4_0_S_BID;
  wire [1:0] axi4_0_S_BREADY;
  wire [3:0] axi4_0_S_BRESP;
  wire [1:0] axi4_0_S_BUSER;
  wire [1:0] axi4_0_S_BVALID;
  wire [63:0] axi4_0_S_RDATA;
  wire [1:0] axi4_0_S_RID;
  wire [1:0] axi4_0_S_RLAST;
  wire [1:0] axi4_0_S_RREADY;
  wire [3:0] axi4_0_S_RRESP;
  wire [1:0] axi4_0_S_RUSER;
  wire [1:0] axi4_0_S_RVALID;
  wire [63:0] axi4_0_S_WDATA;
  wire [1:0] axi4_0_S_WLAST;
  wire [1:0] axi4_0_S_WREADY;
  wire [7:0] axi4_0_S_WSTRB;
  wire [1:0] axi4_0_S_WUSER;
  wire [1:0] axi4_0_S_WVALID;
  wire [351:0] axi4lite_0_M_ARADDR;
  wire [21:0] axi4lite_0_M_ARBURST;
  wire [43:0] axi4lite_0_M_ARCACHE;
  wire [10:0] axi4lite_0_M_ARESETN;
  wire [10:0] axi4lite_0_M_ARID;
  wire [87:0] axi4lite_0_M_ARLEN;
  wire [21:0] axi4lite_0_M_ARLOCK;
  wire [32:0] axi4lite_0_M_ARPROT;
  wire [10:0] axi4lite_0_M_ARREADY;
  wire [32:0] axi4lite_0_M_ARSIZE;
  wire [10:0] axi4lite_0_M_ARVALID;
  wire [351:0] axi4lite_0_M_AWADDR;
  wire [21:0] axi4lite_0_M_AWBURST;
  wire [43:0] axi4lite_0_M_AWCACHE;
  wire [10:0] axi4lite_0_M_AWID;
  wire [87:0] axi4lite_0_M_AWLEN;
  wire [21:0] axi4lite_0_M_AWLOCK;
  wire [32:0] axi4lite_0_M_AWPROT;
  wire [10:0] axi4lite_0_M_AWREADY;
  wire [32:0] axi4lite_0_M_AWSIZE;
  wire [10:0] axi4lite_0_M_AWVALID;
  wire [10:0] axi4lite_0_M_BID;
  wire [10:0] axi4lite_0_M_BREADY;
  wire [21:0] axi4lite_0_M_BRESP;
  wire [10:0] axi4lite_0_M_BVALID;
  wire [351:0] axi4lite_0_M_RDATA;
  wire [10:0] axi4lite_0_M_RID;
  wire [10:0] axi4lite_0_M_RLAST;
  wire [10:0] axi4lite_0_M_RREADY;
  wire [21:0] axi4lite_0_M_RRESP;
  wire [10:0] axi4lite_0_M_RVALID;
  wire [351:0] axi4lite_0_M_WDATA;
  wire [10:0] axi4lite_0_M_WLAST;
  wire [10:0] axi4lite_0_M_WREADY;
  wire [43:0] axi4lite_0_M_WSTRB;
  wire [10:0] axi4lite_0_M_WVALID;
  wire [63:0] axi4lite_0_S_ARADDR;
  wire [3:0] axi4lite_0_S_ARBURST;
  wire [7:0] axi4lite_0_S_ARCACHE;
  wire [1:0] axi4lite_0_S_ARID;
  wire [15:0] axi4lite_0_S_ARLEN;
  wire [3:0] axi4lite_0_S_ARLOCK;
  wire [5:0] axi4lite_0_S_ARPROT;
  wire [7:0] axi4lite_0_S_ARQOS;
  wire [1:0] axi4lite_0_S_ARREADY;
  wire [5:0] axi4lite_0_S_ARSIZE;
  wire [1:0] axi4lite_0_S_ARVALID;
  wire [63:0] axi4lite_0_S_AWADDR;
  wire [3:0] axi4lite_0_S_AWBURST;
  wire [7:0] axi4lite_0_S_AWCACHE;
  wire [1:0] axi4lite_0_S_AWID;
  wire [15:0] axi4lite_0_S_AWLEN;
  wire [3:0] axi4lite_0_S_AWLOCK;
  wire [5:0] axi4lite_0_S_AWPROT;
  wire [7:0] axi4lite_0_S_AWQOS;
  wire [1:0] axi4lite_0_S_AWREADY;
  wire [5:0] axi4lite_0_S_AWSIZE;
  wire [1:0] axi4lite_0_S_AWVALID;
  wire [1:0] axi4lite_0_S_BID;
  wire [1:0] axi4lite_0_S_BREADY;
  wire [3:0] axi4lite_0_S_BRESP;
  wire [1:0] axi4lite_0_S_BVALID;
  wire [63:0] axi4lite_0_S_RDATA;
  wire [1:0] axi4lite_0_S_RID;
  wire [1:0] axi4lite_0_S_RLAST;
  wire [1:0] axi4lite_0_S_RREADY;
  wire [3:0] axi4lite_0_S_RRESP;
  wire [1:0] axi4lite_0_S_RVALID;
  wire [63:0] axi4lite_0_S_WDATA;
  wire [1:0] axi4lite_0_S_WLAST;
  wire [1:0] axi4lite_0_S_WREADY;
  wire [7:0] axi4lite_0_S_WSTRB;
  wire [1:0] axi4lite_0_S_WVALID;
  wire [31:0] axi_bram_ctrl_0_BRAM_Addr_A;
  wire axi_bram_ctrl_0_BRAM_Clk_A;
  wire axi_bram_ctrl_0_BRAM_En_A;
  wire [31:0] axi_bram_ctrl_0_BRAM_RdData_A;
  wire axi_bram_ctrl_0_BRAM_Rst_A;
  wire [3:0] axi_bram_ctrl_0_BRAM_WE_A;
  wire [31:0] axi_bram_ctrl_0_BRAM_WrData_A;
  wire axi_timer_0_Interrupt;
  wire [0:0] clk_100_0000MHzPLL0;
  wire clk_600_0000MHz180PLL0_nobuf;
  wire clk_600_0000MHzPLL0_nobuf;
  wire [0:31] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr;
  wire microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk;
  wire [0:31] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din;
  wire [0:31] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout;
  wire microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN;
  wire microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst;
  wire [0:3] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN;
  wire microblaze_0_debug_Dbg_Capture;
  wire microblaze_0_debug_Dbg_Clk;
  wire [0:7] microblaze_0_debug_Dbg_Reg_En;
  wire microblaze_0_debug_Dbg_Shift;
  wire microblaze_0_debug_Dbg_TDI;
  wire microblaze_0_debug_Dbg_TDO;
  wire microblaze_0_debug_Dbg_Update;
  wire microblaze_0_debug_Debug_Rst;
  wire [0:31] microblaze_0_dlmb_LMB_ABus;
  wire microblaze_0_dlmb_LMB_AddrStrobe;
  wire [0:3] microblaze_0_dlmb_LMB_BE;
  wire microblaze_0_dlmb_LMB_CE;
  wire [0:31] microblaze_0_dlmb_LMB_ReadDBus;
  wire microblaze_0_dlmb_LMB_ReadStrobe;
  wire microblaze_0_dlmb_LMB_Ready;
  wire microblaze_0_dlmb_LMB_Rst;
  wire microblaze_0_dlmb_LMB_UE;
  wire microblaze_0_dlmb_LMB_Wait;
  wire [0:31] microblaze_0_dlmb_LMB_WriteDBus;
  wire microblaze_0_dlmb_LMB_WriteStrobe;
  wire [0:31] microblaze_0_dlmb_M_ABus;
  wire microblaze_0_dlmb_M_AddrStrobe;
  wire [0:3] microblaze_0_dlmb_M_BE;
  wire [0:31] microblaze_0_dlmb_M_DBus;
  wire microblaze_0_dlmb_M_ReadStrobe;
  wire microblaze_0_dlmb_M_WriteStrobe;
  wire [0:0] microblaze_0_dlmb_Sl_CE;
  wire [0:31] microblaze_0_dlmb_Sl_DBus;
  wire [0:0] microblaze_0_dlmb_Sl_Ready;
  wire [0:0] microblaze_0_dlmb_Sl_UE;
  wire [0:0] microblaze_0_dlmb_Sl_Wait;
  wire [0:31] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr;
  wire microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk;
  wire [0:31] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din;
  wire [0:31] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout;
  wire microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN;
  wire microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst;
  wire [0:3] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN;
  wire [0:31] microblaze_0_ilmb_LMB_ABus;
  wire microblaze_0_ilmb_LMB_AddrStrobe;
  wire [0:3] microblaze_0_ilmb_LMB_BE;
  wire microblaze_0_ilmb_LMB_CE;
  wire [0:31] microblaze_0_ilmb_LMB_ReadDBus;
  wire microblaze_0_ilmb_LMB_ReadStrobe;
  wire microblaze_0_ilmb_LMB_Ready;
  wire microblaze_0_ilmb_LMB_Rst;
  wire microblaze_0_ilmb_LMB_UE;
  wire microblaze_0_ilmb_LMB_Wait;
  wire [0:31] microblaze_0_ilmb_LMB_WriteDBus;
  wire microblaze_0_ilmb_LMB_WriteStrobe;
  wire [0:31] microblaze_0_ilmb_M_ABus;
  wire microblaze_0_ilmb_M_AddrStrobe;
  wire microblaze_0_ilmb_M_ReadStrobe;
  wire [0:0] microblaze_0_ilmb_Sl_CE;
  wire [0:31] microblaze_0_ilmb_Sl_DBus;
  wire [0:0] microblaze_0_ilmb_Sl_Ready;
  wire [0:0] microblaze_0_ilmb_Sl_UE;
  wire [0:0] microblaze_0_ilmb_Sl_Wait;
  wire microblaze_0_interrupt;
  wire net_gnd0;
  wire [0:0] net_gnd1;
  wire [1:0] net_gnd2;
  wire [0:2] net_gnd3;
  wire [0:3] net_gnd4;
  wire [7:0] net_gnd8;
  wire [10:0] net_gnd11;
  wire [0:15] net_gnd16;
  wire [0:31] net_gnd32;
  wire [0:4095] net_gnd4096;
  wire net_vcc0;
  wire [0:0] pgassign1;
  wire [0:0] pgassign2;
  wire [0:6] pgassign3;
  wire [0:0] pgassign4;
  wire [1:0] pgassign5;
  wire [1:0] pgassign6;
  wire [10:0] pgassign7;
  wire [1:0] pgassign8;
  wire [31:0] pgassign9;
  wire [0:0] proc_sys_reset_0_BUS_STRUCT_RESET;
  wire proc_sys_reset_0_Dcm_locked;
  wire [0:0] proc_sys_reset_0_Interconnect_aresetn;
  wire proc_sys_reset_0_MB_Debug_Sys_Rst;
  wire proc_sys_reset_0_MB_Reset;

  // Internal assignments

  assign axi_bram_ctrl_0_BRAM_Rst_A_pin = axi_bram_ctrl_0_BRAM_Rst_A;
  assign axi_bram_ctrl_0_BRAM_Clk_A_pin = axi_bram_ctrl_0_BRAM_Clk_A;
  assign axi_bram_ctrl_0_BRAM_WrData_A_pin = axi_bram_ctrl_0_BRAM_WrData_A;
  assign axi_bram_ctrl_0_BRAM_Addr_A_pin = axi_bram_ctrl_0_BRAM_Addr_A;
  assign axi_bram_ctrl_0_BRAM_RdData_A = axi_bram_ctrl_0_BRAM_RdData_A_pin;
  assign axi_bram_ctrl_0_BRAM_En_A_pin = axi_bram_ctrl_0_BRAM_En_A;
  assign axi_bram_ctrl_0_BRAM_WE_A_pin = axi_bram_ctrl_0_BRAM_WE_A;
  assign axi4lite_0_M_BID[0:0] = 1'b0;
  assign axi4lite_0_M_BID[1:1] = 1'b0;
  assign axi4lite_0_M_BID[2:2] = 1'b0;
  assign axi4lite_0_M_BID[3:3] = 1'b0;
  assign axi4lite_0_M_BID[4:4] = 1'b0;
  assign axi4lite_0_M_BID[5:5] = 1'b0;
  assign axi4lite_0_M_BID[7:7] = 1'b0;
  assign axi4lite_0_M_BID[9:9] = 1'b0;
  assign axi4lite_0_M_RID[0:0] = 1'b0;
  assign axi4lite_0_M_RID[1:1] = 1'b0;
  assign axi4lite_0_M_RID[2:2] = 1'b0;
  assign axi4lite_0_M_RID[3:3] = 1'b0;
  assign axi4lite_0_M_RID[4:4] = 1'b0;
  assign axi4lite_0_M_RID[5:5] = 1'b0;
  assign axi4lite_0_M_RID[7:7] = 1'b0;
  assign axi4lite_0_M_RID[9:9] = 1'b0;
  assign axi4lite_0_M_RLAST[0:0] = 1'b0;
  assign axi4lite_0_M_RLAST[1:1] = 1'b0;
  assign axi4lite_0_M_RLAST[2:2] = 1'b0;
  assign axi4lite_0_M_RLAST[3:3] = 1'b0;
  assign axi4lite_0_M_RLAST[4:4] = 1'b0;
  assign axi4lite_0_M_RLAST[5:5] = 1'b0;
  assign axi4lite_0_M_RLAST[7:7] = 1'b0;
  assign axi4lite_0_M_RLAST[9:9] = 1'b0;
  assign pgassign3[0:6] = 7'b0000000;
  assign pgassign4[0:0] = 1'b0;
  assign Linear_Flash_oe_n = pgassign1[0];
  assign Linear_Flash_ce_n = pgassign2[0];
  assign pgassign5[1] = Ethernet_Lite_IP2INTC_Irpt;
  assign pgassign5[0] = axi_timer_0_Interrupt;
  assign pgassign6[1:1] = clk_100_0000MHzPLL0[0:0];
  assign pgassign6[0:0] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[10:10] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[9:9] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[8:8] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[7:7] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[6:6] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[5:5] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[4:4] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[3:3] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[2:2] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[1:1] = clk_100_0000MHzPLL0[0:0];
  assign pgassign7[0:0] = clk_100_0000MHzPLL0[0:0];
  assign pgassign8[1:1] = clk_100_0000MHzPLL0[0:0];
  assign pgassign8[0:0] = clk_100_0000MHzPLL0[0:0];
  assign Linear_Flash_address[0:23] = pgassign9[24:1];
  assign net_gnd0 = 1'b0;
  assign net_gnd1[0:0] = 1'b0;
  assign net_gnd11[10:0] = 11'b00000000000;
  assign net_gnd16[0:15] = 16'b0000000000000000;
  assign net_gnd2[1:0] = 2'b00;
  assign net_gnd3[0:2] = 3'b000;
  assign net_gnd32[0:31] = 32'b00000000000000000000000000000000;
  assign net_gnd4[0:3] = 4'b0000;
  assign net_gnd4096[0:4095] = 4096'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  assign net_gnd8[7:0] = 8'b00000000;
  assign net_vcc0 = 1'b1;

  proc_sys_reset_0_wrapper
    proc_sys_reset_0 (
      .Slowest_sync_clk ( clk_100_0000MHzPLL0[0] ),
      .Ext_Reset_In ( RESET ),
      .Aux_Reset_In ( net_gnd0 ),
      .MB_Debug_Sys_Rst ( proc_sys_reset_0_MB_Debug_Sys_Rst ),
      .Core_Reset_Req_0 ( net_gnd0 ),
      .Chip_Reset_Req_0 ( net_gnd0 ),
      .System_Reset_Req_0 ( net_gnd0 ),
      .Core_Reset_Req_1 ( net_gnd0 ),
      .Chip_Reset_Req_1 ( net_gnd0 ),
      .System_Reset_Req_1 ( net_gnd0 ),
      .Dcm_locked ( proc_sys_reset_0_Dcm_locked ),
      .RstcPPCresetcore_0 (  ),
      .RstcPPCresetchip_0 (  ),
      .RstcPPCresetsys_0 (  ),
      .RstcPPCresetcore_1 (  ),
      .RstcPPCresetchip_1 (  ),
      .RstcPPCresetsys_1 (  ),
      .MB_Reset ( proc_sys_reset_0_MB_Reset ),
      .Bus_Struct_Reset ( proc_sys_reset_0_BUS_STRUCT_RESET[0:0] ),
      .Peripheral_Reset (  ),
      .Interconnect_aresetn ( proc_sys_reset_0_Interconnect_aresetn[0:0] ),
      .Peripheral_aresetn (  )
    );

  microblaze_0_intc_wrapper
    microblaze_0_intc (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[0] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[31:0] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[0] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[0] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[31:0] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[3:0] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[0] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[0] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[1:0] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[0] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[0] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[31:0] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[0] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[0] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[31:0] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[1:0] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[0] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[0] ),
      .Intr ( pgassign5 ),
      .Irq ( microblaze_0_interrupt )
    );

  microblaze_0_ilmb_wrapper
    microblaze_0_ilmb (
      .LMB_Clk ( clk_100_0000MHzPLL0[0] ),
      .SYS_Rst ( proc_sys_reset_0_BUS_STRUCT_RESET[0] ),
      .LMB_Rst ( microblaze_0_ilmb_LMB_Rst ),
      .M_ABus ( microblaze_0_ilmb_M_ABus ),
      .M_ReadStrobe ( microblaze_0_ilmb_M_ReadStrobe ),
      .M_WriteStrobe ( net_gnd0 ),
      .M_AddrStrobe ( microblaze_0_ilmb_M_AddrStrobe ),
      .M_DBus ( net_gnd32 ),
      .M_BE ( net_gnd4 ),
      .Sl_DBus ( microblaze_0_ilmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_ilmb_Sl_Ready[0:0] ),
      .Sl_Wait ( microblaze_0_ilmb_Sl_Wait[0:0] ),
      .Sl_UE ( microblaze_0_ilmb_Sl_UE[0:0] ),
      .Sl_CE ( microblaze_0_ilmb_Sl_CE[0:0] ),
      .LMB_ABus ( microblaze_0_ilmb_LMB_ABus ),
      .LMB_ReadStrobe ( microblaze_0_ilmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_ilmb_LMB_WriteStrobe ),
      .LMB_AddrStrobe ( microblaze_0_ilmb_LMB_AddrStrobe ),
      .LMB_ReadDBus ( microblaze_0_ilmb_LMB_ReadDBus ),
      .LMB_WriteDBus ( microblaze_0_ilmb_LMB_WriteDBus ),
      .LMB_Ready ( microblaze_0_ilmb_LMB_Ready ),
      .LMB_Wait ( microblaze_0_ilmb_LMB_Wait ),
      .LMB_UE ( microblaze_0_ilmb_LMB_UE ),
      .LMB_CE ( microblaze_0_ilmb_LMB_CE ),
      .LMB_BE ( microblaze_0_ilmb_LMB_BE )
    );

  microblaze_0_i_bram_ctrl_wrapper
    microblaze_0_i_bram_ctrl (
      .LMB_Clk ( clk_100_0000MHzPLL0[0] ),
      .LMB_Rst ( microblaze_0_ilmb_LMB_Rst ),
      .LMB_ABus ( microblaze_0_ilmb_LMB_ABus ),
      .LMB_WriteDBus ( microblaze_0_ilmb_LMB_WriteDBus ),
      .LMB_AddrStrobe ( microblaze_0_ilmb_LMB_AddrStrobe ),
      .LMB_ReadStrobe ( microblaze_0_ilmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_ilmb_LMB_WriteStrobe ),
      .LMB_BE ( microblaze_0_ilmb_LMB_BE ),
      .Sl_DBus ( microblaze_0_ilmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_ilmb_Sl_Ready[0] ),
      .Sl_Wait ( microblaze_0_ilmb_Sl_Wait[0] ),
      .Sl_UE ( microblaze_0_ilmb_Sl_UE[0] ),
      .Sl_CE ( microblaze_0_ilmb_Sl_CE[0] ),
      .BRAM_Rst_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout ),
      .Interrupt (  ),
      .SPLB_CTRL_PLB_ABus ( net_gnd32 ),
      .SPLB_CTRL_PLB_PAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_masterID ( net_gnd1[0:0] ),
      .SPLB_CTRL_PLB_RNW ( net_gnd0 ),
      .SPLB_CTRL_PLB_BE ( net_gnd4 ),
      .SPLB_CTRL_PLB_size ( net_gnd4 ),
      .SPLB_CTRL_PLB_type ( net_gnd3 ),
      .SPLB_CTRL_PLB_wrDBus ( net_gnd32 ),
      .SPLB_CTRL_Sl_addrAck (  ),
      .SPLB_CTRL_Sl_SSize (  ),
      .SPLB_CTRL_Sl_wait (  ),
      .SPLB_CTRL_Sl_rearbitrate (  ),
      .SPLB_CTRL_Sl_wrDAck (  ),
      .SPLB_CTRL_Sl_wrComp (  ),
      .SPLB_CTRL_Sl_rdDBus (  ),
      .SPLB_CTRL_Sl_rdDAck (  ),
      .SPLB_CTRL_Sl_rdComp (  ),
      .SPLB_CTRL_Sl_MBusy (  ),
      .SPLB_CTRL_Sl_MWrErr (  ),
      .SPLB_CTRL_Sl_MRdErr (  ),
      .SPLB_CTRL_PLB_UABus ( net_gnd32 ),
      .SPLB_CTRL_PLB_SAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_abort ( net_gnd0 ),
      .SPLB_CTRL_PLB_busLock ( net_gnd0 ),
      .SPLB_CTRL_PLB_MSize ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_lockErr ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_rdPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_reqPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_TAttribute ( net_gnd16 ),
      .SPLB_CTRL_Sl_wrBTerm (  ),
      .SPLB_CTRL_Sl_rdWdAddr (  ),
      .SPLB_CTRL_Sl_rdBTerm (  ),
      .SPLB_CTRL_Sl_MIRQ (  ),
      .S_AXI_CTRL_ACLK ( net_vcc0 ),
      .S_AXI_CTRL_ARESETN ( net_gnd0 ),
      .S_AXI_CTRL_AWADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32[0:31] ),
      .S_AXI_CTRL_WSTRB ( net_gnd4[0:3] ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 )
    );

  microblaze_0_dlmb_wrapper
    microblaze_0_dlmb (
      .LMB_Clk ( clk_100_0000MHzPLL0[0] ),
      .SYS_Rst ( proc_sys_reset_0_BUS_STRUCT_RESET[0] ),
      .LMB_Rst ( microblaze_0_dlmb_LMB_Rst ),
      .M_ABus ( microblaze_0_dlmb_M_ABus ),
      .M_ReadStrobe ( microblaze_0_dlmb_M_ReadStrobe ),
      .M_WriteStrobe ( microblaze_0_dlmb_M_WriteStrobe ),
      .M_AddrStrobe ( microblaze_0_dlmb_M_AddrStrobe ),
      .M_DBus ( microblaze_0_dlmb_M_DBus ),
      .M_BE ( microblaze_0_dlmb_M_BE ),
      .Sl_DBus ( microblaze_0_dlmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_dlmb_Sl_Ready[0:0] ),
      .Sl_Wait ( microblaze_0_dlmb_Sl_Wait[0:0] ),
      .Sl_UE ( microblaze_0_dlmb_Sl_UE[0:0] ),
      .Sl_CE ( microblaze_0_dlmb_Sl_CE[0:0] ),
      .LMB_ABus ( microblaze_0_dlmb_LMB_ABus ),
      .LMB_ReadStrobe ( microblaze_0_dlmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_dlmb_LMB_WriteStrobe ),
      .LMB_AddrStrobe ( microblaze_0_dlmb_LMB_AddrStrobe ),
      .LMB_ReadDBus ( microblaze_0_dlmb_LMB_ReadDBus ),
      .LMB_WriteDBus ( microblaze_0_dlmb_LMB_WriteDBus ),
      .LMB_Ready ( microblaze_0_dlmb_LMB_Ready ),
      .LMB_Wait ( microblaze_0_dlmb_LMB_Wait ),
      .LMB_UE ( microblaze_0_dlmb_LMB_UE ),
      .LMB_CE ( microblaze_0_dlmb_LMB_CE ),
      .LMB_BE ( microblaze_0_dlmb_LMB_BE )
    );

  microblaze_0_d_bram_ctrl_wrapper
    microblaze_0_d_bram_ctrl (
      .LMB_Clk ( clk_100_0000MHzPLL0[0] ),
      .LMB_Rst ( microblaze_0_dlmb_LMB_Rst ),
      .LMB_ABus ( microblaze_0_dlmb_LMB_ABus ),
      .LMB_WriteDBus ( microblaze_0_dlmb_LMB_WriteDBus ),
      .LMB_AddrStrobe ( microblaze_0_dlmb_LMB_AddrStrobe ),
      .LMB_ReadStrobe ( microblaze_0_dlmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_dlmb_LMB_WriteStrobe ),
      .LMB_BE ( microblaze_0_dlmb_LMB_BE ),
      .Sl_DBus ( microblaze_0_dlmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_dlmb_Sl_Ready[0] ),
      .Sl_Wait ( microblaze_0_dlmb_Sl_Wait[0] ),
      .Sl_UE ( microblaze_0_dlmb_Sl_UE[0] ),
      .Sl_CE ( microblaze_0_dlmb_Sl_CE[0] ),
      .BRAM_Rst_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout ),
      .Interrupt (  ),
      .SPLB_CTRL_PLB_ABus ( net_gnd32 ),
      .SPLB_CTRL_PLB_PAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_masterID ( net_gnd1[0:0] ),
      .SPLB_CTRL_PLB_RNW ( net_gnd0 ),
      .SPLB_CTRL_PLB_BE ( net_gnd4 ),
      .SPLB_CTRL_PLB_size ( net_gnd4 ),
      .SPLB_CTRL_PLB_type ( net_gnd3 ),
      .SPLB_CTRL_PLB_wrDBus ( net_gnd32 ),
      .SPLB_CTRL_Sl_addrAck (  ),
      .SPLB_CTRL_Sl_SSize (  ),
      .SPLB_CTRL_Sl_wait (  ),
      .SPLB_CTRL_Sl_rearbitrate (  ),
      .SPLB_CTRL_Sl_wrDAck (  ),
      .SPLB_CTRL_Sl_wrComp (  ),
      .SPLB_CTRL_Sl_rdDBus (  ),
      .SPLB_CTRL_Sl_rdDAck (  ),
      .SPLB_CTRL_Sl_rdComp (  ),
      .SPLB_CTRL_Sl_MBusy (  ),
      .SPLB_CTRL_Sl_MWrErr (  ),
      .SPLB_CTRL_Sl_MRdErr (  ),
      .SPLB_CTRL_PLB_UABus ( net_gnd32 ),
      .SPLB_CTRL_PLB_SAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_abort ( net_gnd0 ),
      .SPLB_CTRL_PLB_busLock ( net_gnd0 ),
      .SPLB_CTRL_PLB_MSize ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_lockErr ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_rdPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_reqPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_TAttribute ( net_gnd16 ),
      .SPLB_CTRL_Sl_wrBTerm (  ),
      .SPLB_CTRL_Sl_rdWdAddr (  ),
      .SPLB_CTRL_Sl_rdBTerm (  ),
      .SPLB_CTRL_Sl_MIRQ (  ),
      .S_AXI_CTRL_ACLK ( net_vcc0 ),
      .S_AXI_CTRL_ARESETN ( net_gnd0 ),
      .S_AXI_CTRL_AWADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32[0:31] ),
      .S_AXI_CTRL_WSTRB ( net_gnd4[0:3] ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 )
    );

  microblaze_0_bram_block_wrapper
    microblaze_0_bram_block (
      .BRAM_Rst_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout ),
      .BRAM_Rst_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout )
    );

  microblaze_0_wrapper
    microblaze_0 (
      .CLK ( clk_100_0000MHzPLL0[0] ),
      .RESET ( microblaze_0_dlmb_LMB_Rst ),
      .MB_RESET ( proc_sys_reset_0_MB_Reset ),
      .INTERRUPT ( microblaze_0_interrupt ),
      .EXT_BRK ( Ext_BRK ),
      .EXT_NM_BRK ( Ext_NM_BRK ),
      .DBG_STOP ( net_gnd0 ),
      .MB_Halted (  ),
      .MB_Error (  ),
      .LOCKSTEP_MASTER_OUT (  ),
      .LOCKSTEP_SLAVE_IN ( net_gnd4096 ),
      .LOCKSTEP_OUT (  ),
      .INSTR ( microblaze_0_ilmb_LMB_ReadDBus ),
      .IREADY ( microblaze_0_ilmb_LMB_Ready ),
      .IWAIT ( microblaze_0_ilmb_LMB_Wait ),
      .ICE ( microblaze_0_ilmb_LMB_CE ),
      .IUE ( microblaze_0_ilmb_LMB_UE ),
      .INSTR_ADDR ( microblaze_0_ilmb_M_ABus ),
      .IFETCH ( microblaze_0_ilmb_M_ReadStrobe ),
      .I_AS ( microblaze_0_ilmb_M_AddrStrobe ),
      .IPLB_M_ABort (  ),
      .IPLB_M_ABus (  ),
      .IPLB_M_UABus (  ),
      .IPLB_M_BE (  ),
      .IPLB_M_busLock (  ),
      .IPLB_M_lockErr (  ),
      .IPLB_M_MSize (  ),
      .IPLB_M_priority (  ),
      .IPLB_M_rdBurst (  ),
      .IPLB_M_request (  ),
      .IPLB_M_RNW (  ),
      .IPLB_M_size (  ),
      .IPLB_M_TAttribute (  ),
      .IPLB_M_type (  ),
      .IPLB_M_wrBurst (  ),
      .IPLB_M_wrDBus (  ),
      .IPLB_MBusy ( net_gnd0 ),
      .IPLB_MRdErr ( net_gnd0 ),
      .IPLB_MWrErr ( net_gnd0 ),
      .IPLB_MIRQ ( net_gnd0 ),
      .IPLB_MWrBTerm ( net_gnd0 ),
      .IPLB_MWrDAck ( net_gnd0 ),
      .IPLB_MAddrAck ( net_gnd0 ),
      .IPLB_MRdBTerm ( net_gnd0 ),
      .IPLB_MRdDAck ( net_gnd0 ),
      .IPLB_MRdDBus ( net_gnd32 ),
      .IPLB_MRdWdAddr ( net_gnd4 ),
      .IPLB_MRearbitrate ( net_gnd0 ),
      .IPLB_MSSize ( net_gnd2[1:0] ),
      .IPLB_MTimeout ( net_gnd0 ),
      .DATA_READ ( microblaze_0_dlmb_LMB_ReadDBus ),
      .DREADY ( microblaze_0_dlmb_LMB_Ready ),
      .DWAIT ( microblaze_0_dlmb_LMB_Wait ),
      .DCE ( microblaze_0_dlmb_LMB_CE ),
      .DUE ( microblaze_0_dlmb_LMB_UE ),
      .DATA_WRITE ( microblaze_0_dlmb_M_DBus ),
      .DATA_ADDR ( microblaze_0_dlmb_M_ABus ),
      .D_AS ( microblaze_0_dlmb_M_AddrStrobe ),
      .READ_STROBE ( microblaze_0_dlmb_M_ReadStrobe ),
      .WRITE_STROBE ( microblaze_0_dlmb_M_WriteStrobe ),
      .BYTE_ENABLE ( microblaze_0_dlmb_M_BE ),
      .DPLB_M_ABort (  ),
      .DPLB_M_ABus (  ),
      .DPLB_M_UABus (  ),
      .DPLB_M_BE (  ),
      .DPLB_M_busLock (  ),
      .DPLB_M_lockErr (  ),
      .DPLB_M_MSize (  ),
      .DPLB_M_priority (  ),
      .DPLB_M_rdBurst (  ),
      .DPLB_M_request (  ),
      .DPLB_M_RNW (  ),
      .DPLB_M_size (  ),
      .DPLB_M_TAttribute (  ),
      .DPLB_M_type (  ),
      .DPLB_M_wrBurst (  ),
      .DPLB_M_wrDBus (  ),
      .DPLB_MBusy ( net_gnd0 ),
      .DPLB_MRdErr ( net_gnd0 ),
      .DPLB_MWrErr ( net_gnd0 ),
      .DPLB_MIRQ ( net_gnd0 ),
      .DPLB_MWrBTerm ( net_gnd0 ),
      .DPLB_MWrDAck ( net_gnd0 ),
      .DPLB_MAddrAck ( net_gnd0 ),
      .DPLB_MRdBTerm ( net_gnd0 ),
      .DPLB_MRdDAck ( net_gnd0 ),
      .DPLB_MRdDBus ( net_gnd32 ),
      .DPLB_MRdWdAddr ( net_gnd4 ),
      .DPLB_MRearbitrate ( net_gnd0 ),
      .DPLB_MSSize ( net_gnd2[1:0] ),
      .DPLB_MTimeout ( net_gnd0 ),
      .M_AXI_IP_AWID ( axi4lite_0_S_AWID[1:1] ),
      .M_AXI_IP_AWADDR ( axi4lite_0_S_AWADDR[63:32] ),
      .M_AXI_IP_AWLEN ( axi4lite_0_S_AWLEN[15:8] ),
      .M_AXI_IP_AWSIZE ( axi4lite_0_S_AWSIZE[5:3] ),
      .M_AXI_IP_AWBURST ( axi4lite_0_S_AWBURST[3:2] ),
      .M_AXI_IP_AWLOCK ( axi4lite_0_S_AWLOCK[2] ),
      .M_AXI_IP_AWCACHE ( axi4lite_0_S_AWCACHE[7:4] ),
      .M_AXI_IP_AWPROT ( axi4lite_0_S_AWPROT[5:3] ),
      .M_AXI_IP_AWQOS ( axi4lite_0_S_AWQOS[7:4] ),
      .M_AXI_IP_AWVALID ( axi4lite_0_S_AWVALID[1] ),
      .M_AXI_IP_AWREADY ( axi4lite_0_S_AWREADY[1] ),
      .M_AXI_IP_WDATA ( axi4lite_0_S_WDATA[63:32] ),
      .M_AXI_IP_WSTRB ( axi4lite_0_S_WSTRB[7:4] ),
      .M_AXI_IP_WLAST ( axi4lite_0_S_WLAST[1] ),
      .M_AXI_IP_WVALID ( axi4lite_0_S_WVALID[1] ),
      .M_AXI_IP_WREADY ( axi4lite_0_S_WREADY[1] ),
      .M_AXI_IP_BID ( axi4lite_0_S_BID[1:1] ),
      .M_AXI_IP_BRESP ( axi4lite_0_S_BRESP[3:2] ),
      .M_AXI_IP_BVALID ( axi4lite_0_S_BVALID[1] ),
      .M_AXI_IP_BREADY ( axi4lite_0_S_BREADY[1] ),
      .M_AXI_IP_ARID ( axi4lite_0_S_ARID[1:1] ),
      .M_AXI_IP_ARADDR ( axi4lite_0_S_ARADDR[63:32] ),
      .M_AXI_IP_ARLEN ( axi4lite_0_S_ARLEN[15:8] ),
      .M_AXI_IP_ARSIZE ( axi4lite_0_S_ARSIZE[5:3] ),
      .M_AXI_IP_ARBURST ( axi4lite_0_S_ARBURST[3:2] ),
      .M_AXI_IP_ARLOCK ( axi4lite_0_S_ARLOCK[2] ),
      .M_AXI_IP_ARCACHE ( axi4lite_0_S_ARCACHE[7:4] ),
      .M_AXI_IP_ARPROT ( axi4lite_0_S_ARPROT[5:3] ),
      .M_AXI_IP_ARQOS ( axi4lite_0_S_ARQOS[7:4] ),
      .M_AXI_IP_ARVALID ( axi4lite_0_S_ARVALID[1] ),
      .M_AXI_IP_ARREADY ( axi4lite_0_S_ARREADY[1] ),
      .M_AXI_IP_RID ( axi4lite_0_S_RID[1:1] ),
      .M_AXI_IP_RDATA ( axi4lite_0_S_RDATA[63:32] ),
      .M_AXI_IP_RRESP ( axi4lite_0_S_RRESP[3:2] ),
      .M_AXI_IP_RLAST ( axi4lite_0_S_RLAST[1] ),
      .M_AXI_IP_RVALID ( axi4lite_0_S_RVALID[1] ),
      .M_AXI_IP_RREADY ( axi4lite_0_S_RREADY[1] ),
      .M_AXI_DP_AWID ( axi4lite_0_S_AWID[0:0] ),
      .M_AXI_DP_AWADDR ( axi4lite_0_S_AWADDR[31:0] ),
      .M_AXI_DP_AWLEN ( axi4lite_0_S_AWLEN[7:0] ),
      .M_AXI_DP_AWSIZE ( axi4lite_0_S_AWSIZE[2:0] ),
      .M_AXI_DP_AWBURST ( axi4lite_0_S_AWBURST[1:0] ),
      .M_AXI_DP_AWLOCK ( axi4lite_0_S_AWLOCK[0] ),
      .M_AXI_DP_AWCACHE ( axi4lite_0_S_AWCACHE[3:0] ),
      .M_AXI_DP_AWPROT ( axi4lite_0_S_AWPROT[2:0] ),
      .M_AXI_DP_AWQOS ( axi4lite_0_S_AWQOS[3:0] ),
      .M_AXI_DP_AWVALID ( axi4lite_0_S_AWVALID[0] ),
      .M_AXI_DP_AWREADY ( axi4lite_0_S_AWREADY[0] ),
      .M_AXI_DP_WDATA ( axi4lite_0_S_WDATA[31:0] ),
      .M_AXI_DP_WSTRB ( axi4lite_0_S_WSTRB[3:0] ),
      .M_AXI_DP_WLAST ( axi4lite_0_S_WLAST[0] ),
      .M_AXI_DP_WVALID ( axi4lite_0_S_WVALID[0] ),
      .M_AXI_DP_WREADY ( axi4lite_0_S_WREADY[0] ),
      .M_AXI_DP_BID ( axi4lite_0_S_BID[0:0] ),
      .M_AXI_DP_BRESP ( axi4lite_0_S_BRESP[1:0] ),
      .M_AXI_DP_BVALID ( axi4lite_0_S_BVALID[0] ),
      .M_AXI_DP_BREADY ( axi4lite_0_S_BREADY[0] ),
      .M_AXI_DP_ARID ( axi4lite_0_S_ARID[0:0] ),
      .M_AXI_DP_ARADDR ( axi4lite_0_S_ARADDR[31:0] ),
      .M_AXI_DP_ARLEN ( axi4lite_0_S_ARLEN[7:0] ),
      .M_AXI_DP_ARSIZE ( axi4lite_0_S_ARSIZE[2:0] ),
      .M_AXI_DP_ARBURST ( axi4lite_0_S_ARBURST[1:0] ),
      .M_AXI_DP_ARLOCK ( axi4lite_0_S_ARLOCK[0] ),
      .M_AXI_DP_ARCACHE ( axi4lite_0_S_ARCACHE[3:0] ),
      .M_AXI_DP_ARPROT ( axi4lite_0_S_ARPROT[2:0] ),
      .M_AXI_DP_ARQOS ( axi4lite_0_S_ARQOS[3:0] ),
      .M_AXI_DP_ARVALID ( axi4lite_0_S_ARVALID[0] ),
      .M_AXI_DP_ARREADY ( axi4lite_0_S_ARREADY[0] ),
      .M_AXI_DP_RID ( axi4lite_0_S_RID[0:0] ),
      .M_AXI_DP_RDATA ( axi4lite_0_S_RDATA[31:0] ),
      .M_AXI_DP_RRESP ( axi4lite_0_S_RRESP[1:0] ),
      .M_AXI_DP_RLAST ( axi4lite_0_S_RLAST[0] ),
      .M_AXI_DP_RVALID ( axi4lite_0_S_RVALID[0] ),
      .M_AXI_DP_RREADY ( axi4lite_0_S_RREADY[0] ),
      .M_AXI_IC_AWID ( axi4_0_S_AWID[1:1] ),
      .M_AXI_IC_AWADDR ( axi4_0_S_AWADDR[63:32] ),
      .M_AXI_IC_AWLEN ( axi4_0_S_AWLEN[15:8] ),
      .M_AXI_IC_AWSIZE ( axi4_0_S_AWSIZE[5:3] ),
      .M_AXI_IC_AWBURST ( axi4_0_S_AWBURST[3:2] ),
      .M_AXI_IC_AWLOCK ( axi4_0_S_AWLOCK[2] ),
      .M_AXI_IC_AWCACHE ( axi4_0_S_AWCACHE[7:4] ),
      .M_AXI_IC_AWPROT ( axi4_0_S_AWPROT[5:3] ),
      .M_AXI_IC_AWQOS ( axi4_0_S_AWQOS[7:4] ),
      .M_AXI_IC_AWVALID ( axi4_0_S_AWVALID[1] ),
      .M_AXI_IC_AWREADY ( axi4_0_S_AWREADY[1] ),
      .M_AXI_IC_AWUSER ( axi4_0_S_AWUSER[9:5] ),
      .M_AXI_IC_WDATA ( axi4_0_S_WDATA[63:32] ),
      .M_AXI_IC_WSTRB ( axi4_0_S_WSTRB[7:4] ),
      .M_AXI_IC_WLAST ( axi4_0_S_WLAST[1] ),
      .M_AXI_IC_WVALID ( axi4_0_S_WVALID[1] ),
      .M_AXI_IC_WREADY ( axi4_0_S_WREADY[1] ),
      .M_AXI_IC_WUSER ( axi4_0_S_WUSER[1:1] ),
      .M_AXI_IC_BID ( axi4_0_S_BID[1:1] ),
      .M_AXI_IC_BRESP ( axi4_0_S_BRESP[3:2] ),
      .M_AXI_IC_BVALID ( axi4_0_S_BVALID[1] ),
      .M_AXI_IC_BREADY ( axi4_0_S_BREADY[1] ),
      .M_AXI_IC_BUSER ( axi4_0_S_BUSER[1:1] ),
      .M_AXI_IC_ARID ( axi4_0_S_ARID[1:1] ),
      .M_AXI_IC_ARADDR ( axi4_0_S_ARADDR[63:32] ),
      .M_AXI_IC_ARLEN ( axi4_0_S_ARLEN[15:8] ),
      .M_AXI_IC_ARSIZE ( axi4_0_S_ARSIZE[5:3] ),
      .M_AXI_IC_ARBURST ( axi4_0_S_ARBURST[3:2] ),
      .M_AXI_IC_ARLOCK ( axi4_0_S_ARLOCK[2] ),
      .M_AXI_IC_ARCACHE ( axi4_0_S_ARCACHE[7:4] ),
      .M_AXI_IC_ARPROT ( axi4_0_S_ARPROT[5:3] ),
      .M_AXI_IC_ARQOS ( axi4_0_S_ARQOS[7:4] ),
      .M_AXI_IC_ARVALID ( axi4_0_S_ARVALID[1] ),
      .M_AXI_IC_ARREADY ( axi4_0_S_ARREADY[1] ),
      .M_AXI_IC_ARUSER ( axi4_0_S_ARUSER[9:5] ),
      .M_AXI_IC_RID ( axi4_0_S_RID[1:1] ),
      .M_AXI_IC_RDATA ( axi4_0_S_RDATA[63:32] ),
      .M_AXI_IC_RRESP ( axi4_0_S_RRESP[3:2] ),
      .M_AXI_IC_RLAST ( axi4_0_S_RLAST[1] ),
      .M_AXI_IC_RVALID ( axi4_0_S_RVALID[1] ),
      .M_AXI_IC_RREADY ( axi4_0_S_RREADY[1] ),
      .M_AXI_IC_RUSER ( axi4_0_S_RUSER[1:1] ),
      .M_AXI_DC_AWID ( axi4_0_S_AWID[0:0] ),
      .M_AXI_DC_AWADDR ( axi4_0_S_AWADDR[31:0] ),
      .M_AXI_DC_AWLEN ( axi4_0_S_AWLEN[7:0] ),
      .M_AXI_DC_AWSIZE ( axi4_0_S_AWSIZE[2:0] ),
      .M_AXI_DC_AWBURST ( axi4_0_S_AWBURST[1:0] ),
      .M_AXI_DC_AWLOCK ( axi4_0_S_AWLOCK[0] ),
      .M_AXI_DC_AWCACHE ( axi4_0_S_AWCACHE[3:0] ),
      .M_AXI_DC_AWPROT ( axi4_0_S_AWPROT[2:0] ),
      .M_AXI_DC_AWQOS ( axi4_0_S_AWQOS[3:0] ),
      .M_AXI_DC_AWVALID ( axi4_0_S_AWVALID[0] ),
      .M_AXI_DC_AWREADY ( axi4_0_S_AWREADY[0] ),
      .M_AXI_DC_AWUSER ( axi4_0_S_AWUSER[4:0] ),
      .M_AXI_DC_WDATA ( axi4_0_S_WDATA[31:0] ),
      .M_AXI_DC_WSTRB ( axi4_0_S_WSTRB[3:0] ),
      .M_AXI_DC_WLAST ( axi4_0_S_WLAST[0] ),
      .M_AXI_DC_WVALID ( axi4_0_S_WVALID[0] ),
      .M_AXI_DC_WREADY ( axi4_0_S_WREADY[0] ),
      .M_AXI_DC_WUSER ( axi4_0_S_WUSER[0:0] ),
      .M_AXI_DC_BID ( axi4_0_S_BID[0:0] ),
      .M_AXI_DC_BRESP ( axi4_0_S_BRESP[1:0] ),
      .M_AXI_DC_BVALID ( axi4_0_S_BVALID[0] ),
      .M_AXI_DC_BREADY ( axi4_0_S_BREADY[0] ),
      .M_AXI_DC_BUSER ( axi4_0_S_BUSER[0:0] ),
      .M_AXI_DC_ARID ( axi4_0_S_ARID[0:0] ),
      .M_AXI_DC_ARADDR ( axi4_0_S_ARADDR[31:0] ),
      .M_AXI_DC_ARLEN ( axi4_0_S_ARLEN[7:0] ),
      .M_AXI_DC_ARSIZE ( axi4_0_S_ARSIZE[2:0] ),
      .M_AXI_DC_ARBURST ( axi4_0_S_ARBURST[1:0] ),
      .M_AXI_DC_ARLOCK ( axi4_0_S_ARLOCK[0] ),
      .M_AXI_DC_ARCACHE ( axi4_0_S_ARCACHE[3:0] ),
      .M_AXI_DC_ARPROT ( axi4_0_S_ARPROT[2:0] ),
      .M_AXI_DC_ARQOS ( axi4_0_S_ARQOS[3:0] ),
      .M_AXI_DC_ARVALID ( axi4_0_S_ARVALID[0] ),
      .M_AXI_DC_ARREADY ( axi4_0_S_ARREADY[0] ),
      .M_AXI_DC_ARUSER ( axi4_0_S_ARUSER[4:0] ),
      .M_AXI_DC_RID ( axi4_0_S_RID[0:0] ),
      .M_AXI_DC_RDATA ( axi4_0_S_RDATA[31:0] ),
      .M_AXI_DC_RRESP ( axi4_0_S_RRESP[1:0] ),
      .M_AXI_DC_RLAST ( axi4_0_S_RLAST[0] ),
      .M_AXI_DC_RVALID ( axi4_0_S_RVALID[0] ),
      .M_AXI_DC_RREADY ( axi4_0_S_RREADY[0] ),
      .M_AXI_DC_RUSER ( axi4_0_S_RUSER[0:0] ),
      .DBG_CLK ( microblaze_0_debug_Dbg_Clk ),
      .DBG_TDI ( microblaze_0_debug_Dbg_TDI ),
      .DBG_TDO ( microblaze_0_debug_Dbg_TDO ),
      .DBG_REG_EN ( microblaze_0_debug_Dbg_Reg_En ),
      .DBG_SHIFT ( microblaze_0_debug_Dbg_Shift ),
      .DBG_CAPTURE ( microblaze_0_debug_Dbg_Capture ),
      .DBG_UPDATE ( microblaze_0_debug_Dbg_Update ),
      .DEBUG_RST ( microblaze_0_debug_Debug_Rst ),
      .Trace_Instruction (  ),
      .Trace_Valid_Instr (  ),
      .Trace_PC (  ),
      .Trace_Reg_Write (  ),
      .Trace_Reg_Addr (  ),
      .Trace_MSR_Reg (  ),
      .Trace_PID_Reg (  ),
      .Trace_New_Reg_Value (  ),
      .Trace_Exception_Taken (  ),
      .Trace_Exception_Kind (  ),
      .Trace_Jump_Taken (  ),
      .Trace_Delay_Slot (  ),
      .Trace_Data_Address (  ),
      .Trace_Data_Access (  ),
      .Trace_Data_Read (  ),
      .Trace_Data_Write (  ),
      .Trace_Data_Write_Value (  ),
      .Trace_Data_Byte_Enable (  ),
      .Trace_DCache_Req (  ),
      .Trace_DCache_Hit (  ),
      .Trace_DCache_Rdy (  ),
      .Trace_DCache_Read (  ),
      .Trace_ICache_Req (  ),
      .Trace_ICache_Hit (  ),
      .Trace_ICache_Rdy (  ),
      .Trace_OF_PipeRun (  ),
      .Trace_EX_PipeRun (  ),
      .Trace_MEM_PipeRun (  ),
      .Trace_MB_Halted (  ),
      .Trace_Jump_Hit (  ),
      .FSL0_S_CLK (  ),
      .FSL0_S_READ (  ),
      .FSL0_S_DATA ( net_gnd32 ),
      .FSL0_S_CONTROL ( net_gnd0 ),
      .FSL0_S_EXISTS ( net_gnd0 ),
      .FSL0_M_CLK (  ),
      .FSL0_M_WRITE (  ),
      .FSL0_M_DATA (  ),
      .FSL0_M_CONTROL (  ),
      .FSL0_M_FULL ( net_gnd0 ),
      .FSL1_S_CLK (  ),
      .FSL1_S_READ (  ),
      .FSL1_S_DATA ( net_gnd32 ),
      .FSL1_S_CONTROL ( net_gnd0 ),
      .FSL1_S_EXISTS ( net_gnd0 ),
      .FSL1_M_CLK (  ),
      .FSL1_M_WRITE (  ),
      .FSL1_M_DATA (  ),
      .FSL1_M_CONTROL (  ),
      .FSL1_M_FULL ( net_gnd0 ),
      .FSL2_S_CLK (  ),
      .FSL2_S_READ (  ),
      .FSL2_S_DATA ( net_gnd32 ),
      .FSL2_S_CONTROL ( net_gnd0 ),
      .FSL2_S_EXISTS ( net_gnd0 ),
      .FSL2_M_CLK (  ),
      .FSL2_M_WRITE (  ),
      .FSL2_M_DATA (  ),
      .FSL2_M_CONTROL (  ),
      .FSL2_M_FULL ( net_gnd0 ),
      .FSL3_S_CLK (  ),
      .FSL3_S_READ (  ),
      .FSL3_S_DATA ( net_gnd32 ),
      .FSL3_S_CONTROL ( net_gnd0 ),
      .FSL3_S_EXISTS ( net_gnd0 ),
      .FSL3_M_CLK (  ),
      .FSL3_M_WRITE (  ),
      .FSL3_M_DATA (  ),
      .FSL3_M_CONTROL (  ),
      .FSL3_M_FULL ( net_gnd0 ),
      .FSL4_S_CLK (  ),
      .FSL4_S_READ (  ),
      .FSL4_S_DATA ( net_gnd32 ),
      .FSL4_S_CONTROL ( net_gnd0 ),
      .FSL4_S_EXISTS ( net_gnd0 ),
      .FSL4_M_CLK (  ),
      .FSL4_M_WRITE (  ),
      .FSL4_M_DATA (  ),
      .FSL4_M_CONTROL (  ),
      .FSL4_M_FULL ( net_gnd0 ),
      .FSL5_S_CLK (  ),
      .FSL5_S_READ (  ),
      .FSL5_S_DATA ( net_gnd32 ),
      .FSL5_S_CONTROL ( net_gnd0 ),
      .FSL5_S_EXISTS ( net_gnd0 ),
      .FSL5_M_CLK (  ),
      .FSL5_M_WRITE (  ),
      .FSL5_M_DATA (  ),
      .FSL5_M_CONTROL (  ),
      .FSL5_M_FULL ( net_gnd0 ),
      .FSL6_S_CLK (  ),
      .FSL6_S_READ (  ),
      .FSL6_S_DATA ( net_gnd32 ),
      .FSL6_S_CONTROL ( net_gnd0 ),
      .FSL6_S_EXISTS ( net_gnd0 ),
      .FSL6_M_CLK (  ),
      .FSL6_M_WRITE (  ),
      .FSL6_M_DATA (  ),
      .FSL6_M_CONTROL (  ),
      .FSL6_M_FULL ( net_gnd0 ),
      .FSL7_S_CLK (  ),
      .FSL7_S_READ (  ),
      .FSL7_S_DATA ( net_gnd32 ),
      .FSL7_S_CONTROL ( net_gnd0 ),
      .FSL7_S_EXISTS ( net_gnd0 ),
      .FSL7_M_CLK (  ),
      .FSL7_M_WRITE (  ),
      .FSL7_M_DATA (  ),
      .FSL7_M_CONTROL (  ),
      .FSL7_M_FULL ( net_gnd0 ),
      .FSL8_S_CLK (  ),
      .FSL8_S_READ (  ),
      .FSL8_S_DATA ( net_gnd32 ),
      .FSL8_S_CONTROL ( net_gnd0 ),
      .FSL8_S_EXISTS ( net_gnd0 ),
      .FSL8_M_CLK (  ),
      .FSL8_M_WRITE (  ),
      .FSL8_M_DATA (  ),
      .FSL8_M_CONTROL (  ),
      .FSL8_M_FULL ( net_gnd0 ),
      .FSL9_S_CLK (  ),
      .FSL9_S_READ (  ),
      .FSL9_S_DATA ( net_gnd32 ),
      .FSL9_S_CONTROL ( net_gnd0 ),
      .FSL9_S_EXISTS ( net_gnd0 ),
      .FSL9_M_CLK (  ),
      .FSL9_M_WRITE (  ),
      .FSL9_M_DATA (  ),
      .FSL9_M_CONTROL (  ),
      .FSL9_M_FULL ( net_gnd0 ),
      .FSL10_S_CLK (  ),
      .FSL10_S_READ (  ),
      .FSL10_S_DATA ( net_gnd32 ),
      .FSL10_S_CONTROL ( net_gnd0 ),
      .FSL10_S_EXISTS ( net_gnd0 ),
      .FSL10_M_CLK (  ),
      .FSL10_M_WRITE (  ),
      .FSL10_M_DATA (  ),
      .FSL10_M_CONTROL (  ),
      .FSL10_M_FULL ( net_gnd0 ),
      .FSL11_S_CLK (  ),
      .FSL11_S_READ (  ),
      .FSL11_S_DATA ( net_gnd32 ),
      .FSL11_S_CONTROL ( net_gnd0 ),
      .FSL11_S_EXISTS ( net_gnd0 ),
      .FSL11_M_CLK (  ),
      .FSL11_M_WRITE (  ),
      .FSL11_M_DATA (  ),
      .FSL11_M_CONTROL (  ),
      .FSL11_M_FULL ( net_gnd0 ),
      .FSL12_S_CLK (  ),
      .FSL12_S_READ (  ),
      .FSL12_S_DATA ( net_gnd32 ),
      .FSL12_S_CONTROL ( net_gnd0 ),
      .FSL12_S_EXISTS ( net_gnd0 ),
      .FSL12_M_CLK (  ),
      .FSL12_M_WRITE (  ),
      .FSL12_M_DATA (  ),
      .FSL12_M_CONTROL (  ),
      .FSL12_M_FULL ( net_gnd0 ),
      .FSL13_S_CLK (  ),
      .FSL13_S_READ (  ),
      .FSL13_S_DATA ( net_gnd32 ),
      .FSL13_S_CONTROL ( net_gnd0 ),
      .FSL13_S_EXISTS ( net_gnd0 ),
      .FSL13_M_CLK (  ),
      .FSL13_M_WRITE (  ),
      .FSL13_M_DATA (  ),
      .FSL13_M_CONTROL (  ),
      .FSL13_M_FULL ( net_gnd0 ),
      .FSL14_S_CLK (  ),
      .FSL14_S_READ (  ),
      .FSL14_S_DATA ( net_gnd32 ),
      .FSL14_S_CONTROL ( net_gnd0 ),
      .FSL14_S_EXISTS ( net_gnd0 ),
      .FSL14_M_CLK (  ),
      .FSL14_M_WRITE (  ),
      .FSL14_M_DATA (  ),
      .FSL14_M_CONTROL (  ),
      .FSL14_M_FULL ( net_gnd0 ),
      .FSL15_S_CLK (  ),
      .FSL15_S_READ (  ),
      .FSL15_S_DATA ( net_gnd32 ),
      .FSL15_S_CONTROL ( net_gnd0 ),
      .FSL15_S_EXISTS ( net_gnd0 ),
      .FSL15_M_CLK (  ),
      .FSL15_M_WRITE (  ),
      .FSL15_M_DATA (  ),
      .FSL15_M_CONTROL (  ),
      .FSL15_M_FULL ( net_gnd0 ),
      .M0_AXIS_TLAST (  ),
      .M0_AXIS_TDATA (  ),
      .M0_AXIS_TVALID (  ),
      .M0_AXIS_TREADY ( net_gnd0 ),
      .S0_AXIS_TLAST ( net_gnd0 ),
      .S0_AXIS_TDATA ( net_gnd32[0:31] ),
      .S0_AXIS_TVALID ( net_gnd0 ),
      .S0_AXIS_TREADY (  ),
      .M1_AXIS_TLAST (  ),
      .M1_AXIS_TDATA (  ),
      .M1_AXIS_TVALID (  ),
      .M1_AXIS_TREADY ( net_gnd0 ),
      .S1_AXIS_TLAST ( net_gnd0 ),
      .S1_AXIS_TDATA ( net_gnd32[0:31] ),
      .S1_AXIS_TVALID ( net_gnd0 ),
      .S1_AXIS_TREADY (  ),
      .M2_AXIS_TLAST (  ),
      .M2_AXIS_TDATA (  ),
      .M2_AXIS_TVALID (  ),
      .M2_AXIS_TREADY ( net_gnd0 ),
      .S2_AXIS_TLAST ( net_gnd0 ),
      .S2_AXIS_TDATA ( net_gnd32[0:31] ),
      .S2_AXIS_TVALID ( net_gnd0 ),
      .S2_AXIS_TREADY (  ),
      .M3_AXIS_TLAST (  ),
      .M3_AXIS_TDATA (  ),
      .M3_AXIS_TVALID (  ),
      .M3_AXIS_TREADY ( net_gnd0 ),
      .S3_AXIS_TLAST ( net_gnd0 ),
      .S3_AXIS_TDATA ( net_gnd32[0:31] ),
      .S3_AXIS_TVALID ( net_gnd0 ),
      .S3_AXIS_TREADY (  ),
      .M4_AXIS_TLAST (  ),
      .M4_AXIS_TDATA (  ),
      .M4_AXIS_TVALID (  ),
      .M4_AXIS_TREADY ( net_gnd0 ),
      .S4_AXIS_TLAST ( net_gnd0 ),
      .S4_AXIS_TDATA ( net_gnd32[0:31] ),
      .S4_AXIS_TVALID ( net_gnd0 ),
      .S4_AXIS_TREADY (  ),
      .M5_AXIS_TLAST (  ),
      .M5_AXIS_TDATA (  ),
      .M5_AXIS_TVALID (  ),
      .M5_AXIS_TREADY ( net_gnd0 ),
      .S5_AXIS_TLAST ( net_gnd0 ),
      .S5_AXIS_TDATA ( net_gnd32[0:31] ),
      .S5_AXIS_TVALID ( net_gnd0 ),
      .S5_AXIS_TREADY (  ),
      .M6_AXIS_TLAST (  ),
      .M6_AXIS_TDATA (  ),
      .M6_AXIS_TVALID (  ),
      .M6_AXIS_TREADY ( net_gnd0 ),
      .S6_AXIS_TLAST ( net_gnd0 ),
      .S6_AXIS_TDATA ( net_gnd32[0:31] ),
      .S6_AXIS_TVALID ( net_gnd0 ),
      .S6_AXIS_TREADY (  ),
      .M7_AXIS_TLAST (  ),
      .M7_AXIS_TDATA (  ),
      .M7_AXIS_TVALID (  ),
      .M7_AXIS_TREADY ( net_gnd0 ),
      .S7_AXIS_TLAST ( net_gnd0 ),
      .S7_AXIS_TDATA ( net_gnd32[0:31] ),
      .S7_AXIS_TVALID ( net_gnd0 ),
      .S7_AXIS_TREADY (  ),
      .M8_AXIS_TLAST (  ),
      .M8_AXIS_TDATA (  ),
      .M8_AXIS_TVALID (  ),
      .M8_AXIS_TREADY ( net_gnd0 ),
      .S8_AXIS_TLAST ( net_gnd0 ),
      .S8_AXIS_TDATA ( net_gnd32[0:31] ),
      .S8_AXIS_TVALID ( net_gnd0 ),
      .S8_AXIS_TREADY (  ),
      .M9_AXIS_TLAST (  ),
      .M9_AXIS_TDATA (  ),
      .M9_AXIS_TVALID (  ),
      .M9_AXIS_TREADY ( net_gnd0 ),
      .S9_AXIS_TLAST ( net_gnd0 ),
      .S9_AXIS_TDATA ( net_gnd32[0:31] ),
      .S9_AXIS_TVALID ( net_gnd0 ),
      .S9_AXIS_TREADY (  ),
      .M10_AXIS_TLAST (  ),
      .M10_AXIS_TDATA (  ),
      .M10_AXIS_TVALID (  ),
      .M10_AXIS_TREADY ( net_gnd0 ),
      .S10_AXIS_TLAST ( net_gnd0 ),
      .S10_AXIS_TDATA ( net_gnd32[0:31] ),
      .S10_AXIS_TVALID ( net_gnd0 ),
      .S10_AXIS_TREADY (  ),
      .M11_AXIS_TLAST (  ),
      .M11_AXIS_TDATA (  ),
      .M11_AXIS_TVALID (  ),
      .M11_AXIS_TREADY ( net_gnd0 ),
      .S11_AXIS_TLAST ( net_gnd0 ),
      .S11_AXIS_TDATA ( net_gnd32[0:31] ),
      .S11_AXIS_TVALID ( net_gnd0 ),
      .S11_AXIS_TREADY (  ),
      .M12_AXIS_TLAST (  ),
      .M12_AXIS_TDATA (  ),
      .M12_AXIS_TVALID (  ),
      .M12_AXIS_TREADY ( net_gnd0 ),
      .S12_AXIS_TLAST ( net_gnd0 ),
      .S12_AXIS_TDATA ( net_gnd32[0:31] ),
      .S12_AXIS_TVALID ( net_gnd0 ),
      .S12_AXIS_TREADY (  ),
      .M13_AXIS_TLAST (  ),
      .M13_AXIS_TDATA (  ),
      .M13_AXIS_TVALID (  ),
      .M13_AXIS_TREADY ( net_gnd0 ),
      .S13_AXIS_TLAST ( net_gnd0 ),
      .S13_AXIS_TDATA ( net_gnd32[0:31] ),
      .S13_AXIS_TVALID ( net_gnd0 ),
      .S13_AXIS_TREADY (  ),
      .M14_AXIS_TLAST (  ),
      .M14_AXIS_TDATA (  ),
      .M14_AXIS_TVALID (  ),
      .M14_AXIS_TREADY ( net_gnd0 ),
      .S14_AXIS_TLAST ( net_gnd0 ),
      .S14_AXIS_TDATA ( net_gnd32[0:31] ),
      .S14_AXIS_TVALID ( net_gnd0 ),
      .S14_AXIS_TREADY (  ),
      .M15_AXIS_TLAST (  ),
      .M15_AXIS_TDATA (  ),
      .M15_AXIS_TVALID (  ),
      .M15_AXIS_TREADY ( net_gnd0 ),
      .S15_AXIS_TLAST ( net_gnd0 ),
      .S15_AXIS_TDATA ( net_gnd32[0:31] ),
      .S15_AXIS_TVALID ( net_gnd0 ),
      .S15_AXIS_TREADY (  ),
      .ICACHE_FSL_IN_CLK (  ),
      .ICACHE_FSL_IN_READ (  ),
      .ICACHE_FSL_IN_DATA ( net_gnd32 ),
      .ICACHE_FSL_IN_CONTROL ( net_gnd0 ),
      .ICACHE_FSL_IN_EXISTS ( net_gnd0 ),
      .ICACHE_FSL_OUT_CLK (  ),
      .ICACHE_FSL_OUT_WRITE (  ),
      .ICACHE_FSL_OUT_DATA (  ),
      .ICACHE_FSL_OUT_CONTROL (  ),
      .ICACHE_FSL_OUT_FULL ( net_gnd0 ),
      .DCACHE_FSL_IN_CLK (  ),
      .DCACHE_FSL_IN_READ (  ),
      .DCACHE_FSL_IN_DATA ( net_gnd32 ),
      .DCACHE_FSL_IN_CONTROL ( net_gnd0 ),
      .DCACHE_FSL_IN_EXISTS ( net_gnd0 ),
      .DCACHE_FSL_OUT_CLK (  ),
      .DCACHE_FSL_OUT_WRITE (  ),
      .DCACHE_FSL_OUT_DATA (  ),
      .DCACHE_FSL_OUT_CONTROL (  ),
      .DCACHE_FSL_OUT_FULL ( net_gnd0 )
    );

  debug_module_wrapper
    debug_module (
      .Interrupt (  ),
      .Debug_SYS_Rst ( proc_sys_reset_0_MB_Debug_Sys_Rst ),
      .Ext_BRK ( Ext_BRK ),
      .Ext_NM_BRK ( Ext_NM_BRK ),
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[1] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[63:32] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[1] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[1] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[63:32] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[7:4] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[1] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[1] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[3:2] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[1] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[1] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[63:32] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[1] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[1] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[63:32] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[3:2] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[1] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[1] ),
      .SPLB_Clk ( net_gnd0 ),
      .SPLB_Rst ( net_gnd0 ),
      .PLB_ABus ( net_gnd32 ),
      .PLB_UABus ( net_gnd32 ),
      .PLB_PAValid ( net_gnd0 ),
      .PLB_SAValid ( net_gnd0 ),
      .PLB_rdPrim ( net_gnd0 ),
      .PLB_wrPrim ( net_gnd0 ),
      .PLB_masterID ( net_gnd3 ),
      .PLB_abort ( net_gnd0 ),
      .PLB_busLock ( net_gnd0 ),
      .PLB_RNW ( net_gnd0 ),
      .PLB_BE ( net_gnd4 ),
      .PLB_MSize ( net_gnd2[1:0] ),
      .PLB_size ( net_gnd4 ),
      .PLB_type ( net_gnd3 ),
      .PLB_lockErr ( net_gnd0 ),
      .PLB_wrDBus ( net_gnd32 ),
      .PLB_wrBurst ( net_gnd0 ),
      .PLB_rdBurst ( net_gnd0 ),
      .PLB_wrPendReq ( net_gnd0 ),
      .PLB_rdPendReq ( net_gnd0 ),
      .PLB_wrPendPri ( net_gnd2[1:0] ),
      .PLB_rdPendPri ( net_gnd2[1:0] ),
      .PLB_reqPri ( net_gnd2[1:0] ),
      .PLB_TAttribute ( net_gnd16 ),
      .Sl_addrAck (  ),
      .Sl_SSize (  ),
      .Sl_wait (  ),
      .Sl_rearbitrate (  ),
      .Sl_wrDAck (  ),
      .Sl_wrComp (  ),
      .Sl_wrBTerm (  ),
      .Sl_rdDBus (  ),
      .Sl_rdWdAddr (  ),
      .Sl_rdDAck (  ),
      .Sl_rdComp (  ),
      .Sl_rdBTerm (  ),
      .Sl_MBusy (  ),
      .Sl_MWrErr (  ),
      .Sl_MRdErr (  ),
      .Sl_MIRQ (  ),
      .Dbg_Clk_0 ( microblaze_0_debug_Dbg_Clk ),
      .Dbg_TDI_0 ( microblaze_0_debug_Dbg_TDI ),
      .Dbg_TDO_0 ( microblaze_0_debug_Dbg_TDO ),
      .Dbg_Reg_En_0 ( microblaze_0_debug_Dbg_Reg_En ),
      .Dbg_Capture_0 ( microblaze_0_debug_Dbg_Capture ),
      .Dbg_Shift_0 ( microblaze_0_debug_Dbg_Shift ),
      .Dbg_Update_0 ( microblaze_0_debug_Dbg_Update ),
      .Dbg_Rst_0 ( microblaze_0_debug_Debug_Rst ),
      .Dbg_Clk_1 (  ),
      .Dbg_TDI_1 (  ),
      .Dbg_TDO_1 ( net_gnd0 ),
      .Dbg_Reg_En_1 (  ),
      .Dbg_Capture_1 (  ),
      .Dbg_Shift_1 (  ),
      .Dbg_Update_1 (  ),
      .Dbg_Rst_1 (  ),
      .Dbg_Clk_2 (  ),
      .Dbg_TDI_2 (  ),
      .Dbg_TDO_2 ( net_gnd0 ),
      .Dbg_Reg_En_2 (  ),
      .Dbg_Capture_2 (  ),
      .Dbg_Shift_2 (  ),
      .Dbg_Update_2 (  ),
      .Dbg_Rst_2 (  ),
      .Dbg_Clk_3 (  ),
      .Dbg_TDI_3 (  ),
      .Dbg_TDO_3 ( net_gnd0 ),
      .Dbg_Reg_En_3 (  ),
      .Dbg_Capture_3 (  ),
      .Dbg_Shift_3 (  ),
      .Dbg_Update_3 (  ),
      .Dbg_Rst_3 (  ),
      .Dbg_Clk_4 (  ),
      .Dbg_TDI_4 (  ),
      .Dbg_TDO_4 ( net_gnd0 ),
      .Dbg_Reg_En_4 (  ),
      .Dbg_Capture_4 (  ),
      .Dbg_Shift_4 (  ),
      .Dbg_Update_4 (  ),
      .Dbg_Rst_4 (  ),
      .Dbg_Clk_5 (  ),
      .Dbg_TDI_5 (  ),
      .Dbg_TDO_5 ( net_gnd0 ),
      .Dbg_Reg_En_5 (  ),
      .Dbg_Capture_5 (  ),
      .Dbg_Shift_5 (  ),
      .Dbg_Update_5 (  ),
      .Dbg_Rst_5 (  ),
      .Dbg_Clk_6 (  ),
      .Dbg_TDI_6 (  ),
      .Dbg_TDO_6 ( net_gnd0 ),
      .Dbg_Reg_En_6 (  ),
      .Dbg_Capture_6 (  ),
      .Dbg_Shift_6 (  ),
      .Dbg_Update_6 (  ),
      .Dbg_Rst_6 (  ),
      .Dbg_Clk_7 (  ),
      .Dbg_TDI_7 (  ),
      .Dbg_TDO_7 ( net_gnd0 ),
      .Dbg_Reg_En_7 (  ),
      .Dbg_Capture_7 (  ),
      .Dbg_Shift_7 (  ),
      .Dbg_Update_7 (  ),
      .Dbg_Rst_7 (  ),
      .bscan_tdi (  ),
      .bscan_reset (  ),
      .bscan_shift (  ),
      .bscan_update (  ),
      .bscan_capture (  ),
      .bscan_sel1 (  ),
      .bscan_drck1 (  ),
      .bscan_tdo1 ( net_gnd0 ),
      .Ext_JTAG_DRCK (  ),
      .Ext_JTAG_RESET (  ),
      .Ext_JTAG_SEL (  ),
      .Ext_JTAG_CAPTURE (  ),
      .Ext_JTAG_SHIFT (  ),
      .Ext_JTAG_UPDATE (  ),
      .Ext_JTAG_TDI (  ),
      .Ext_JTAG_TDO ( net_gnd0 )
    );

  clock_generator_0_wrapper
    clock_generator_0 (
      .CLKIN ( CLK ),
      .CLKOUT0 ( clk_600_0000MHzPLL0_nobuf ),
      .CLKOUT1 ( clk_600_0000MHz180PLL0_nobuf ),
      .CLKOUT2 ( clk_100_0000MHzPLL0[0] ),
      .CLKOUT3 (  ),
      .CLKOUT4 (  ),
      .CLKOUT5 (  ),
      .CLKOUT6 (  ),
      .CLKOUT7 (  ),
      .CLKOUT8 (  ),
      .CLKOUT9 (  ),
      .CLKOUT10 (  ),
      .CLKOUT11 (  ),
      .CLKOUT12 (  ),
      .CLKOUT13 (  ),
      .CLKOUT14 (  ),
      .CLKOUT15 (  ),
      .CLKFBIN ( net_gnd0 ),
      .CLKFBOUT (  ),
      .PSCLK ( net_gnd0 ),
      .PSEN ( net_gnd0 ),
      .PSINCDEC ( net_gnd0 ),
      .PSDONE (  ),
      .RST ( RESET ),
      .LOCKED ( proc_sys_reset_0_Dcm_locked )
    );

  axi_timer_0_wrapper
    axi_timer_0 (
      .CaptureTrig0 ( net_gnd0 ),
      .CaptureTrig1 ( net_gnd0 ),
      .GenerateOut0 (  ),
      .GenerateOut1 (  ),
      .PWM0 (  ),
      .Interrupt ( axi_timer_0_Interrupt ),
      .Freeze ( net_gnd0 ),
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[2] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[95:64] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[2] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[2] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[95:64] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[11:8] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[2] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[2] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[5:4] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[2] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[2] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[95:64] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[2] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[2] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[95:64] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[5:4] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[2] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[2] )
    );

  axi4lite_0_wrapper
    axi4lite_0 (
      .INTERCONNECT_ACLK ( clk_100_0000MHzPLL0[0] ),
      .INTERCONNECT_ARESETN ( proc_sys_reset_0_Interconnect_aresetn[0] ),
      .S_AXI_ARESET_OUT_N (  ),
      .M_AXI_ARESET_OUT_N ( axi4lite_0_M_ARESETN ),
      .IRQ (  ),
      .S_AXI_ACLK ( pgassign6 ),
      .S_AXI_AWID ( axi4lite_0_S_AWID ),
      .S_AXI_AWADDR ( axi4lite_0_S_AWADDR ),
      .S_AXI_AWLEN ( axi4lite_0_S_AWLEN ),
      .S_AXI_AWSIZE ( axi4lite_0_S_AWSIZE ),
      .S_AXI_AWBURST ( axi4lite_0_S_AWBURST ),
      .S_AXI_AWLOCK ( axi4lite_0_S_AWLOCK ),
      .S_AXI_AWCACHE ( axi4lite_0_S_AWCACHE ),
      .S_AXI_AWPROT ( axi4lite_0_S_AWPROT ),
      .S_AXI_AWQOS ( axi4lite_0_S_AWQOS ),
      .S_AXI_AWUSER ( net_gnd2 ),
      .S_AXI_AWVALID ( axi4lite_0_S_AWVALID ),
      .S_AXI_AWREADY ( axi4lite_0_S_AWREADY ),
      .S_AXI_WID ( net_gnd2 ),
      .S_AXI_WDATA ( axi4lite_0_S_WDATA ),
      .S_AXI_WSTRB ( axi4lite_0_S_WSTRB ),
      .S_AXI_WLAST ( axi4lite_0_S_WLAST ),
      .S_AXI_WUSER ( net_gnd2 ),
      .S_AXI_WVALID ( axi4lite_0_S_WVALID ),
      .S_AXI_WREADY ( axi4lite_0_S_WREADY ),
      .S_AXI_BID ( axi4lite_0_S_BID ),
      .S_AXI_BRESP ( axi4lite_0_S_BRESP ),
      .S_AXI_BUSER (  ),
      .S_AXI_BVALID ( axi4lite_0_S_BVALID ),
      .S_AXI_BREADY ( axi4lite_0_S_BREADY ),
      .S_AXI_ARID ( axi4lite_0_S_ARID ),
      .S_AXI_ARADDR ( axi4lite_0_S_ARADDR ),
      .S_AXI_ARLEN ( axi4lite_0_S_ARLEN ),
      .S_AXI_ARSIZE ( axi4lite_0_S_ARSIZE ),
      .S_AXI_ARBURST ( axi4lite_0_S_ARBURST ),
      .S_AXI_ARLOCK ( axi4lite_0_S_ARLOCK ),
      .S_AXI_ARCACHE ( axi4lite_0_S_ARCACHE ),
      .S_AXI_ARPROT ( axi4lite_0_S_ARPROT ),
      .S_AXI_ARQOS ( axi4lite_0_S_ARQOS ),
      .S_AXI_ARUSER ( net_gnd2 ),
      .S_AXI_ARVALID ( axi4lite_0_S_ARVALID ),
      .S_AXI_ARREADY ( axi4lite_0_S_ARREADY ),
      .S_AXI_RID ( axi4lite_0_S_RID ),
      .S_AXI_RDATA ( axi4lite_0_S_RDATA ),
      .S_AXI_RRESP ( axi4lite_0_S_RRESP ),
      .S_AXI_RLAST ( axi4lite_0_S_RLAST ),
      .S_AXI_RUSER (  ),
      .S_AXI_RVALID ( axi4lite_0_S_RVALID ),
      .S_AXI_RREADY ( axi4lite_0_S_RREADY ),
      .M_AXI_ACLK ( pgassign7 ),
      .M_AXI_AWID ( axi4lite_0_M_AWID ),
      .M_AXI_AWADDR ( axi4lite_0_M_AWADDR ),
      .M_AXI_AWLEN ( axi4lite_0_M_AWLEN ),
      .M_AXI_AWSIZE ( axi4lite_0_M_AWSIZE ),
      .M_AXI_AWBURST ( axi4lite_0_M_AWBURST ),
      .M_AXI_AWLOCK ( axi4lite_0_M_AWLOCK ),
      .M_AXI_AWCACHE ( axi4lite_0_M_AWCACHE ),
      .M_AXI_AWPROT ( axi4lite_0_M_AWPROT ),
      .M_AXI_AWREGION (  ),
      .M_AXI_AWQOS (  ),
      .M_AXI_AWUSER (  ),
      .M_AXI_AWVALID ( axi4lite_0_M_AWVALID ),
      .M_AXI_AWREADY ( axi4lite_0_M_AWREADY ),
      .M_AXI_WID (  ),
      .M_AXI_WDATA ( axi4lite_0_M_WDATA ),
      .M_AXI_WSTRB ( axi4lite_0_M_WSTRB ),
      .M_AXI_WLAST ( axi4lite_0_M_WLAST ),
      .M_AXI_WUSER (  ),
      .M_AXI_WVALID ( axi4lite_0_M_WVALID ),
      .M_AXI_WREADY ( axi4lite_0_M_WREADY ),
      .M_AXI_BID ( axi4lite_0_M_BID ),
      .M_AXI_BRESP ( axi4lite_0_M_BRESP ),
      .M_AXI_BUSER ( net_gnd11 ),
      .M_AXI_BVALID ( axi4lite_0_M_BVALID ),
      .M_AXI_BREADY ( axi4lite_0_M_BREADY ),
      .M_AXI_ARID ( axi4lite_0_M_ARID ),
      .M_AXI_ARADDR ( axi4lite_0_M_ARADDR ),
      .M_AXI_ARLEN ( axi4lite_0_M_ARLEN ),
      .M_AXI_ARSIZE ( axi4lite_0_M_ARSIZE ),
      .M_AXI_ARBURST ( axi4lite_0_M_ARBURST ),
      .M_AXI_ARLOCK ( axi4lite_0_M_ARLOCK ),
      .M_AXI_ARCACHE ( axi4lite_0_M_ARCACHE ),
      .M_AXI_ARPROT ( axi4lite_0_M_ARPROT ),
      .M_AXI_ARREGION (  ),
      .M_AXI_ARQOS (  ),
      .M_AXI_ARUSER (  ),
      .M_AXI_ARVALID ( axi4lite_0_M_ARVALID ),
      .M_AXI_ARREADY ( axi4lite_0_M_ARREADY ),
      .M_AXI_RID ( axi4lite_0_M_RID ),
      .M_AXI_RDATA ( axi4lite_0_M_RDATA ),
      .M_AXI_RRESP ( axi4lite_0_M_RRESP ),
      .M_AXI_RLAST ( axi4lite_0_M_RLAST ),
      .M_AXI_RUSER ( net_gnd11 ),
      .M_AXI_RVALID ( axi4lite_0_M_RVALID ),
      .M_AXI_RREADY ( axi4lite_0_M_RREADY ),
      .S_AXI_CTRL_AWADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32[0:31] ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 ),
      .INTERCONNECT_ARESET_OUT_N (  ),
      .DEBUG_AW_TRANS_SEQ (  ),
      .DEBUG_AW_ARB_GRANT (  ),
      .DEBUG_AR_TRANS_SEQ (  ),
      .DEBUG_AR_ARB_GRANT (  ),
      .DEBUG_AW_TRANS_QUAL (  ),
      .DEBUG_AW_ACCEPT_CNT (  ),
      .DEBUG_AW_ACTIVE_THREAD (  ),
      .DEBUG_AW_ACTIVE_TARGET (  ),
      .DEBUG_AW_ACTIVE_REGION (  ),
      .DEBUG_AW_ERROR (  ),
      .DEBUG_AW_TARGET (  ),
      .DEBUG_AR_TRANS_QUAL (  ),
      .DEBUG_AR_ACCEPT_CNT (  ),
      .DEBUG_AR_ACTIVE_THREAD (  ),
      .DEBUG_AR_ACTIVE_TARGET (  ),
      .DEBUG_AR_ACTIVE_REGION (  ),
      .DEBUG_AR_ERROR (  ),
      .DEBUG_AR_TARGET (  ),
      .DEBUG_B_TRANS_SEQ (  ),
      .DEBUG_R_BEAT_CNT (  ),
      .DEBUG_R_TRANS_SEQ (  ),
      .DEBUG_AW_ISSUING_CNT (  ),
      .DEBUG_AR_ISSUING_CNT (  ),
      .DEBUG_W_BEAT_CNT (  ),
      .DEBUG_W_TRANS_SEQ (  ),
      .DEBUG_BID_TARGET (  ),
      .DEBUG_BID_ERROR (  ),
      .DEBUG_RID_TARGET (  ),
      .DEBUG_RID_ERROR (  ),
      .DEBUG_SR_SC_ARADDR (  ),
      .DEBUG_SR_SC_ARADDRCONTROL (  ),
      .DEBUG_SR_SC_AWADDR (  ),
      .DEBUG_SR_SC_AWADDRCONTROL (  ),
      .DEBUG_SR_SC_BRESP (  ),
      .DEBUG_SR_SC_RDATA (  ),
      .DEBUG_SR_SC_RDATACONTROL (  ),
      .DEBUG_SR_SC_WDATA (  ),
      .DEBUG_SR_SC_WDATACONTROL (  ),
      .DEBUG_SC_SF_ARADDR (  ),
      .DEBUG_SC_SF_ARADDRCONTROL (  ),
      .DEBUG_SC_SF_AWADDR (  ),
      .DEBUG_SC_SF_AWADDRCONTROL (  ),
      .DEBUG_SC_SF_BRESP (  ),
      .DEBUG_SC_SF_RDATA (  ),
      .DEBUG_SC_SF_RDATACONTROL (  ),
      .DEBUG_SC_SF_WDATA (  ),
      .DEBUG_SC_SF_WDATACONTROL (  ),
      .DEBUG_SF_CB_ARADDR (  ),
      .DEBUG_SF_CB_ARADDRCONTROL (  ),
      .DEBUG_SF_CB_AWADDR (  ),
      .DEBUG_SF_CB_AWADDRCONTROL (  ),
      .DEBUG_SF_CB_BRESP (  ),
      .DEBUG_SF_CB_RDATA (  ),
      .DEBUG_SF_CB_RDATACONTROL (  ),
      .DEBUG_SF_CB_WDATA (  ),
      .DEBUG_SF_CB_WDATACONTROL (  ),
      .DEBUG_CB_MF_ARADDR (  ),
      .DEBUG_CB_MF_ARADDRCONTROL (  ),
      .DEBUG_CB_MF_AWADDR (  ),
      .DEBUG_CB_MF_AWADDRCONTROL (  ),
      .DEBUG_CB_MF_BRESP (  ),
      .DEBUG_CB_MF_RDATA (  ),
      .DEBUG_CB_MF_RDATACONTROL (  ),
      .DEBUG_CB_MF_WDATA (  ),
      .DEBUG_CB_MF_WDATACONTROL (  ),
      .DEBUG_MF_MC_ARADDR (  ),
      .DEBUG_MF_MC_ARADDRCONTROL (  ),
      .DEBUG_MF_MC_AWADDR (  ),
      .DEBUG_MF_MC_AWADDRCONTROL (  ),
      .DEBUG_MF_MC_BRESP (  ),
      .DEBUG_MF_MC_RDATA (  ),
      .DEBUG_MF_MC_RDATACONTROL (  ),
      .DEBUG_MF_MC_WDATA (  ),
      .DEBUG_MF_MC_WDATACONTROL (  ),
      .DEBUG_MC_MP_ARADDR (  ),
      .DEBUG_MC_MP_ARADDRCONTROL (  ),
      .DEBUG_MC_MP_AWADDR (  ),
      .DEBUG_MC_MP_AWADDRCONTROL (  ),
      .DEBUG_MC_MP_BRESP (  ),
      .DEBUG_MC_MP_RDATA (  ),
      .DEBUG_MC_MP_RDATACONTROL (  ),
      .DEBUG_MC_MP_WDATA (  ),
      .DEBUG_MC_MP_WDATACONTROL (  ),
      .DEBUG_MP_MR_ARADDR (  ),
      .DEBUG_MP_MR_ARADDRCONTROL (  ),
      .DEBUG_MP_MR_AWADDR (  ),
      .DEBUG_MP_MR_AWADDRCONTROL (  ),
      .DEBUG_MP_MR_BRESP (  ),
      .DEBUG_MP_MR_RDATA (  ),
      .DEBUG_MP_MR_RDATACONTROL (  ),
      .DEBUG_MP_MR_WDATA (  ),
      .DEBUG_MP_MR_WDATACONTROL (  )
    );

  axi4_0_wrapper
    axi4_0 (
      .INTERCONNECT_ACLK ( clk_100_0000MHzPLL0[0] ),
      .INTERCONNECT_ARESETN ( proc_sys_reset_0_Interconnect_aresetn[0] ),
      .S_AXI_ARESET_OUT_N (  ),
      .M_AXI_ARESET_OUT_N ( axi4_0_M_ARESETN[0:0] ),
      .IRQ (  ),
      .S_AXI_ACLK ( pgassign8 ),
      .S_AXI_AWID ( axi4_0_S_AWID ),
      .S_AXI_AWADDR ( axi4_0_S_AWADDR ),
      .S_AXI_AWLEN ( axi4_0_S_AWLEN ),
      .S_AXI_AWSIZE ( axi4_0_S_AWSIZE ),
      .S_AXI_AWBURST ( axi4_0_S_AWBURST ),
      .S_AXI_AWLOCK ( axi4_0_S_AWLOCK ),
      .S_AXI_AWCACHE ( axi4_0_S_AWCACHE ),
      .S_AXI_AWPROT ( axi4_0_S_AWPROT ),
      .S_AXI_AWQOS ( axi4_0_S_AWQOS ),
      .S_AXI_AWUSER ( axi4_0_S_AWUSER ),
      .S_AXI_AWVALID ( axi4_0_S_AWVALID ),
      .S_AXI_AWREADY ( axi4_0_S_AWREADY ),
      .S_AXI_WID ( net_gnd2 ),
      .S_AXI_WDATA ( axi4_0_S_WDATA ),
      .S_AXI_WSTRB ( axi4_0_S_WSTRB ),
      .S_AXI_WLAST ( axi4_0_S_WLAST ),
      .S_AXI_WUSER ( axi4_0_S_WUSER ),
      .S_AXI_WVALID ( axi4_0_S_WVALID ),
      .S_AXI_WREADY ( axi4_0_S_WREADY ),
      .S_AXI_BID ( axi4_0_S_BID ),
      .S_AXI_BRESP ( axi4_0_S_BRESP ),
      .S_AXI_BUSER ( axi4_0_S_BUSER ),
      .S_AXI_BVALID ( axi4_0_S_BVALID ),
      .S_AXI_BREADY ( axi4_0_S_BREADY ),
      .S_AXI_ARID ( axi4_0_S_ARID ),
      .S_AXI_ARADDR ( axi4_0_S_ARADDR ),
      .S_AXI_ARLEN ( axi4_0_S_ARLEN ),
      .S_AXI_ARSIZE ( axi4_0_S_ARSIZE ),
      .S_AXI_ARBURST ( axi4_0_S_ARBURST ),
      .S_AXI_ARLOCK ( axi4_0_S_ARLOCK ),
      .S_AXI_ARCACHE ( axi4_0_S_ARCACHE ),
      .S_AXI_ARPROT ( axi4_0_S_ARPROT ),
      .S_AXI_ARQOS ( axi4_0_S_ARQOS ),
      .S_AXI_ARUSER ( axi4_0_S_ARUSER ),
      .S_AXI_ARVALID ( axi4_0_S_ARVALID ),
      .S_AXI_ARREADY ( axi4_0_S_ARREADY ),
      .S_AXI_RID ( axi4_0_S_RID ),
      .S_AXI_RDATA ( axi4_0_S_RDATA ),
      .S_AXI_RRESP ( axi4_0_S_RRESP ),
      .S_AXI_RLAST ( axi4_0_S_RLAST ),
      .S_AXI_RUSER ( axi4_0_S_RUSER ),
      .S_AXI_RVALID ( axi4_0_S_RVALID ),
      .S_AXI_RREADY ( axi4_0_S_RREADY ),
      .M_AXI_ACLK ( clk_100_0000MHzPLL0[0:0] ),
      .M_AXI_AWID ( axi4_0_M_AWID[0:0] ),
      .M_AXI_AWADDR ( axi4_0_M_AWADDR ),
      .M_AXI_AWLEN ( axi4_0_M_AWLEN ),
      .M_AXI_AWSIZE ( axi4_0_M_AWSIZE ),
      .M_AXI_AWBURST ( axi4_0_M_AWBURST ),
      .M_AXI_AWLOCK ( axi4_0_M_AWLOCK ),
      .M_AXI_AWCACHE ( axi4_0_M_AWCACHE ),
      .M_AXI_AWPROT ( axi4_0_M_AWPROT ),
      .M_AXI_AWREGION (  ),
      .M_AXI_AWQOS ( axi4_0_M_AWQOS ),
      .M_AXI_AWUSER (  ),
      .M_AXI_AWVALID ( axi4_0_M_AWVALID[0:0] ),
      .M_AXI_AWREADY ( axi4_0_M_AWREADY[0:0] ),
      .M_AXI_WID (  ),
      .M_AXI_WDATA ( axi4_0_M_WDATA ),
      .M_AXI_WSTRB ( axi4_0_M_WSTRB ),
      .M_AXI_WLAST ( axi4_0_M_WLAST[0:0] ),
      .M_AXI_WUSER (  ),
      .M_AXI_WVALID ( axi4_0_M_WVALID[0:0] ),
      .M_AXI_WREADY ( axi4_0_M_WREADY[0:0] ),
      .M_AXI_BID ( axi4_0_M_BID[0:0] ),
      .M_AXI_BRESP ( axi4_0_M_BRESP ),
      .M_AXI_BUSER ( net_gnd1[0:0] ),
      .M_AXI_BVALID ( axi4_0_M_BVALID[0:0] ),
      .M_AXI_BREADY ( axi4_0_M_BREADY[0:0] ),
      .M_AXI_ARID ( axi4_0_M_ARID[0:0] ),
      .M_AXI_ARADDR ( axi4_0_M_ARADDR ),
      .M_AXI_ARLEN ( axi4_0_M_ARLEN ),
      .M_AXI_ARSIZE ( axi4_0_M_ARSIZE ),
      .M_AXI_ARBURST ( axi4_0_M_ARBURST ),
      .M_AXI_ARLOCK ( axi4_0_M_ARLOCK ),
      .M_AXI_ARCACHE ( axi4_0_M_ARCACHE ),
      .M_AXI_ARPROT ( axi4_0_M_ARPROT ),
      .M_AXI_ARREGION (  ),
      .M_AXI_ARQOS ( axi4_0_M_ARQOS ),
      .M_AXI_ARUSER (  ),
      .M_AXI_ARVALID ( axi4_0_M_ARVALID[0:0] ),
      .M_AXI_ARREADY ( axi4_0_M_ARREADY[0:0] ),
      .M_AXI_RID ( axi4_0_M_RID[0:0] ),
      .M_AXI_RDATA ( axi4_0_M_RDATA ),
      .M_AXI_RRESP ( axi4_0_M_RRESP ),
      .M_AXI_RLAST ( axi4_0_M_RLAST[0:0] ),
      .M_AXI_RUSER ( net_gnd1[0:0] ),
      .M_AXI_RVALID ( axi4_0_M_RVALID[0:0] ),
      .M_AXI_RREADY ( axi4_0_M_RREADY[0:0] ),
      .S_AXI_CTRL_AWADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32[0:31] ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 ),
      .INTERCONNECT_ARESET_OUT_N (  ),
      .DEBUG_AW_TRANS_SEQ (  ),
      .DEBUG_AW_ARB_GRANT (  ),
      .DEBUG_AR_TRANS_SEQ (  ),
      .DEBUG_AR_ARB_GRANT (  ),
      .DEBUG_AW_TRANS_QUAL (  ),
      .DEBUG_AW_ACCEPT_CNT (  ),
      .DEBUG_AW_ACTIVE_THREAD (  ),
      .DEBUG_AW_ACTIVE_TARGET (  ),
      .DEBUG_AW_ACTIVE_REGION (  ),
      .DEBUG_AW_ERROR (  ),
      .DEBUG_AW_TARGET (  ),
      .DEBUG_AR_TRANS_QUAL (  ),
      .DEBUG_AR_ACCEPT_CNT (  ),
      .DEBUG_AR_ACTIVE_THREAD (  ),
      .DEBUG_AR_ACTIVE_TARGET (  ),
      .DEBUG_AR_ACTIVE_REGION (  ),
      .DEBUG_AR_ERROR (  ),
      .DEBUG_AR_TARGET (  ),
      .DEBUG_B_TRANS_SEQ (  ),
      .DEBUG_R_BEAT_CNT (  ),
      .DEBUG_R_TRANS_SEQ (  ),
      .DEBUG_AW_ISSUING_CNT (  ),
      .DEBUG_AR_ISSUING_CNT (  ),
      .DEBUG_W_BEAT_CNT (  ),
      .DEBUG_W_TRANS_SEQ (  ),
      .DEBUG_BID_TARGET (  ),
      .DEBUG_BID_ERROR (  ),
      .DEBUG_RID_TARGET (  ),
      .DEBUG_RID_ERROR (  ),
      .DEBUG_SR_SC_ARADDR (  ),
      .DEBUG_SR_SC_ARADDRCONTROL (  ),
      .DEBUG_SR_SC_AWADDR (  ),
      .DEBUG_SR_SC_AWADDRCONTROL (  ),
      .DEBUG_SR_SC_BRESP (  ),
      .DEBUG_SR_SC_RDATA (  ),
      .DEBUG_SR_SC_RDATACONTROL (  ),
      .DEBUG_SR_SC_WDATA (  ),
      .DEBUG_SR_SC_WDATACONTROL (  ),
      .DEBUG_SC_SF_ARADDR (  ),
      .DEBUG_SC_SF_ARADDRCONTROL (  ),
      .DEBUG_SC_SF_AWADDR (  ),
      .DEBUG_SC_SF_AWADDRCONTROL (  ),
      .DEBUG_SC_SF_BRESP (  ),
      .DEBUG_SC_SF_RDATA (  ),
      .DEBUG_SC_SF_RDATACONTROL (  ),
      .DEBUG_SC_SF_WDATA (  ),
      .DEBUG_SC_SF_WDATACONTROL (  ),
      .DEBUG_SF_CB_ARADDR (  ),
      .DEBUG_SF_CB_ARADDRCONTROL (  ),
      .DEBUG_SF_CB_AWADDR (  ),
      .DEBUG_SF_CB_AWADDRCONTROL (  ),
      .DEBUG_SF_CB_BRESP (  ),
      .DEBUG_SF_CB_RDATA (  ),
      .DEBUG_SF_CB_RDATACONTROL (  ),
      .DEBUG_SF_CB_WDATA (  ),
      .DEBUG_SF_CB_WDATACONTROL (  ),
      .DEBUG_CB_MF_ARADDR (  ),
      .DEBUG_CB_MF_ARADDRCONTROL (  ),
      .DEBUG_CB_MF_AWADDR (  ),
      .DEBUG_CB_MF_AWADDRCONTROL (  ),
      .DEBUG_CB_MF_BRESP (  ),
      .DEBUG_CB_MF_RDATA (  ),
      .DEBUG_CB_MF_RDATACONTROL (  ),
      .DEBUG_CB_MF_WDATA (  ),
      .DEBUG_CB_MF_WDATACONTROL (  ),
      .DEBUG_MF_MC_ARADDR (  ),
      .DEBUG_MF_MC_ARADDRCONTROL (  ),
      .DEBUG_MF_MC_AWADDR (  ),
      .DEBUG_MF_MC_AWADDRCONTROL (  ),
      .DEBUG_MF_MC_BRESP (  ),
      .DEBUG_MF_MC_RDATA (  ),
      .DEBUG_MF_MC_RDATACONTROL (  ),
      .DEBUG_MF_MC_WDATA (  ),
      .DEBUG_MF_MC_WDATACONTROL (  ),
      .DEBUG_MC_MP_ARADDR (  ),
      .DEBUG_MC_MP_ARADDRCONTROL (  ),
      .DEBUG_MC_MP_AWADDR (  ),
      .DEBUG_MC_MP_AWADDRCONTROL (  ),
      .DEBUG_MC_MP_BRESP (  ),
      .DEBUG_MC_MP_RDATA (  ),
      .DEBUG_MC_MP_RDATACONTROL (  ),
      .DEBUG_MC_MP_WDATA (  ),
      .DEBUG_MC_MP_WDATACONTROL (  ),
      .DEBUG_MP_MR_ARADDR (  ),
      .DEBUG_MP_MR_ARADDRCONTROL (  ),
      .DEBUG_MP_MR_AWADDR (  ),
      .DEBUG_MP_MR_AWADDRCONTROL (  ),
      .DEBUG_MP_MR_BRESP (  ),
      .DEBUG_MP_MR_RDATA (  ),
      .DEBUG_MP_MR_RDATACONTROL (  ),
      .DEBUG_MP_MR_WDATA (  ),
      .DEBUG_MP_MR_WDATACONTROL (  )
    );

  rs232_usb_wrapper
    RS232_USB (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[3] ),
      .Interrupt (  ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[127:96] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[3] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[3] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[127:96] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[15:12] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[3] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[3] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[7:6] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[3] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[3] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[127:96] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[3] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[3] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[127:96] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[7:6] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[3] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[3] ),
      .RX ( RS232_USB_sin ),
      .TX ( RS232_USB_sout )
    );

  rs232_wrapper
    RS232 (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[4] ),
      .Interrupt (  ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[159:128] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[4] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[4] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[159:128] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[19:16] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[4] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[4] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[9:8] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[4] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[4] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[159:128] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[4] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[4] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[159:128] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[9:8] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[4] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[4] ),
      .RX ( RS232_sin ),
      .TX ( RS232_sout )
    );

  push_buttons_3bits_wrapper
    Push_Buttons_3Bits (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[5] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[191:160] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[5] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[5] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[191:160] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[23:20] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[5] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[5] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[11:10] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[5] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[5] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[191:160] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[5] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[5] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[191:160] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[11:10] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[5] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[5] ),
      .IP2INTC_Irpt (  ),
      .GPIO_IO_I ( Push_Buttons_3Bits_TRI_I ),
      .GPIO_IO_O (  ),
      .GPIO_IO_T (  ),
      .GPIO2_IO_I ( net_gnd32[0:31] ),
      .GPIO2_IO_O (  ),
      .GPIO2_IO_T (  )
    );

  mcb_ddr3_wrapper
    MCB_DDR3 (
      .sysclk_2x ( clk_600_0000MHzPLL0_nobuf ),
      .sysclk_2x_180 ( clk_600_0000MHz180PLL0_nobuf ),
      .pll_ce_0 ( net_vcc0 ),
      .pll_ce_90 ( net_vcc0 ),
      .pll_lock ( proc_sys_reset_0_Dcm_locked ),
      .pll_lock_bufpll_o (  ),
      .sysclk_2x_bufpll_o (  ),
      .sysclk_2x_180_bufpll_o (  ),
      .pll_ce_0_bufpll_o (  ),
      .pll_ce_90_bufpll_o (  ),
      .sys_rst ( proc_sys_reset_0_BUS_STRUCT_RESET[0] ),
      .mcbx_dram_addr ( mcbx_dram_addr ),
      .mcbx_dram_ba ( mcbx_dram_ba ),
      .mcbx_dram_ras_n ( mcbx_dram_ras_n ),
      .mcbx_dram_cas_n ( mcbx_dram_cas_n ),
      .mcbx_dram_we_n ( mcbx_dram_we_n ),
      .mcbx_dram_cke ( mcbx_dram_cke ),
      .mcbx_dram_clk ( mcbx_dram_clk ),
      .mcbx_dram_clk_n ( mcbx_dram_clk_n ),
      .mcbx_dram_dq ( mcbx_dram_dq ),
      .mcbx_dram_dqs ( mcbx_dram_dqs ),
      .mcbx_dram_dqs_n ( mcbx_dram_dqs_n ),
      .mcbx_dram_udqs ( mcbx_dram_udqs ),
      .mcbx_dram_udqs_n ( mcbx_dram_udqs_n ),
      .mcbx_dram_udm ( mcbx_dram_udm ),
      .mcbx_dram_ldm ( mcbx_dram_ldm ),
      .mcbx_dram_odt ( mcbx_dram_odt ),
      .mcbx_dram_ddr3_rst ( mcbx_dram_ddr3_rst ),
      .rzq ( rzq ),
      .zio ( zio ),
      .ui_clk ( clk_100_0000MHzPLL0[0] ),
      .uo_done_cal (  ),
      .s0_axi_aclk ( clk_100_0000MHzPLL0[0] ),
      .s0_axi_aresetn ( axi4_0_M_ARESETN[0] ),
      .s0_axi_awid ( axi4_0_M_AWID[0:0] ),
      .s0_axi_awaddr ( axi4_0_M_AWADDR ),
      .s0_axi_awlen ( axi4_0_M_AWLEN ),
      .s0_axi_awsize ( axi4_0_M_AWSIZE ),
      .s0_axi_awburst ( axi4_0_M_AWBURST ),
      .s0_axi_awlock ( axi4_0_M_AWLOCK[0:0] ),
      .s0_axi_awcache ( axi4_0_M_AWCACHE ),
      .s0_axi_awprot ( axi4_0_M_AWPROT ),
      .s0_axi_awqos ( axi4_0_M_AWQOS ),
      .s0_axi_awvalid ( axi4_0_M_AWVALID[0] ),
      .s0_axi_awready ( axi4_0_M_AWREADY[0] ),
      .s0_axi_wdata ( axi4_0_M_WDATA ),
      .s0_axi_wstrb ( axi4_0_M_WSTRB ),
      .s0_axi_wlast ( axi4_0_M_WLAST[0] ),
      .s0_axi_wvalid ( axi4_0_M_WVALID[0] ),
      .s0_axi_wready ( axi4_0_M_WREADY[0] ),
      .s0_axi_bid ( axi4_0_M_BID[0:0] ),
      .s0_axi_bresp ( axi4_0_M_BRESP ),
      .s0_axi_bvalid ( axi4_0_M_BVALID[0] ),
      .s0_axi_bready ( axi4_0_M_BREADY[0] ),
      .s0_axi_arid ( axi4_0_M_ARID[0:0] ),
      .s0_axi_araddr ( axi4_0_M_ARADDR ),
      .s0_axi_arlen ( axi4_0_M_ARLEN ),
      .s0_axi_arsize ( axi4_0_M_ARSIZE ),
      .s0_axi_arburst ( axi4_0_M_ARBURST ),
      .s0_axi_arlock ( axi4_0_M_ARLOCK[0:0] ),
      .s0_axi_arcache ( axi4_0_M_ARCACHE ),
      .s0_axi_arprot ( axi4_0_M_ARPROT ),
      .s0_axi_arqos ( axi4_0_M_ARQOS ),
      .s0_axi_arvalid ( axi4_0_M_ARVALID[0] ),
      .s0_axi_arready ( axi4_0_M_ARREADY[0] ),
      .s0_axi_rid ( axi4_0_M_RID[0:0] ),
      .s0_axi_rdata ( axi4_0_M_RDATA ),
      .s0_axi_rresp ( axi4_0_M_RRESP ),
      .s0_axi_rlast ( axi4_0_M_RLAST[0] ),
      .s0_axi_rvalid ( axi4_0_M_RVALID[0] ),
      .s0_axi_rready ( axi4_0_M_RREADY[0] ),
      .s1_axi_aclk ( net_gnd0 ),
      .s1_axi_aresetn ( net_gnd0 ),
      .s1_axi_awid ( net_gnd4[0:3] ),
      .s1_axi_awaddr ( net_gnd32[0:31] ),
      .s1_axi_awlen ( net_gnd8 ),
      .s1_axi_awsize ( net_gnd3[0:2] ),
      .s1_axi_awburst ( net_gnd2 ),
      .s1_axi_awlock ( net_gnd1[0:0] ),
      .s1_axi_awcache ( net_gnd4[0:3] ),
      .s1_axi_awprot ( net_gnd3[0:2] ),
      .s1_axi_awqos ( net_gnd4[0:3] ),
      .s1_axi_awvalid ( net_gnd0 ),
      .s1_axi_awready (  ),
      .s1_axi_wdata ( net_gnd32[0:31] ),
      .s1_axi_wstrb ( net_gnd4[0:3] ),
      .s1_axi_wlast ( net_gnd0 ),
      .s1_axi_wvalid ( net_gnd0 ),
      .s1_axi_wready (  ),
      .s1_axi_bid (  ),
      .s1_axi_bresp (  ),
      .s1_axi_bvalid (  ),
      .s1_axi_bready ( net_gnd0 ),
      .s1_axi_arid ( net_gnd4[0:3] ),
      .s1_axi_araddr ( net_gnd32[0:31] ),
      .s1_axi_arlen ( net_gnd8 ),
      .s1_axi_arsize ( net_gnd3[0:2] ),
      .s1_axi_arburst ( net_gnd2 ),
      .s1_axi_arlock ( net_gnd1[0:0] ),
      .s1_axi_arcache ( net_gnd4[0:3] ),
      .s1_axi_arprot ( net_gnd3[0:2] ),
      .s1_axi_arqos ( net_gnd4[0:3] ),
      .s1_axi_arvalid ( net_gnd0 ),
      .s1_axi_arready (  ),
      .s1_axi_rid (  ),
      .s1_axi_rdata (  ),
      .s1_axi_rresp (  ),
      .s1_axi_rlast (  ),
      .s1_axi_rvalid (  ),
      .s1_axi_rready ( net_gnd0 ),
      .s2_axi_aclk ( net_gnd0 ),
      .s2_axi_aresetn ( net_gnd0 ),
      .s2_axi_awid ( net_gnd4[0:3] ),
      .s2_axi_awaddr ( net_gnd32[0:31] ),
      .s2_axi_awlen ( net_gnd8 ),
      .s2_axi_awsize ( net_gnd3[0:2] ),
      .s2_axi_awburst ( net_gnd2 ),
      .s2_axi_awlock ( net_gnd1[0:0] ),
      .s2_axi_awcache ( net_gnd4[0:3] ),
      .s2_axi_awprot ( net_gnd3[0:2] ),
      .s2_axi_awqos ( net_gnd4[0:3] ),
      .s2_axi_awvalid ( net_gnd0 ),
      .s2_axi_awready (  ),
      .s2_axi_wdata ( net_gnd32[0:31] ),
      .s2_axi_wstrb ( net_gnd4[0:3] ),
      .s2_axi_wlast ( net_gnd0 ),
      .s2_axi_wvalid ( net_gnd0 ),
      .s2_axi_wready (  ),
      .s2_axi_bid (  ),
      .s2_axi_bresp (  ),
      .s2_axi_bvalid (  ),
      .s2_axi_bready ( net_gnd0 ),
      .s2_axi_arid ( net_gnd4[0:3] ),
      .s2_axi_araddr ( net_gnd32[0:31] ),
      .s2_axi_arlen ( net_gnd8 ),
      .s2_axi_arsize ( net_gnd3[0:2] ),
      .s2_axi_arburst ( net_gnd2 ),
      .s2_axi_arlock ( net_gnd1[0:0] ),
      .s2_axi_arcache ( net_gnd4[0:3] ),
      .s2_axi_arprot ( net_gnd3[0:2] ),
      .s2_axi_arqos ( net_gnd4[0:3] ),
      .s2_axi_arvalid ( net_gnd0 ),
      .s2_axi_arready (  ),
      .s2_axi_rid (  ),
      .s2_axi_rdata (  ),
      .s2_axi_rresp (  ),
      .s2_axi_rlast (  ),
      .s2_axi_rvalid (  ),
      .s2_axi_rready ( net_gnd0 ),
      .s3_axi_aclk ( net_gnd0 ),
      .s3_axi_aresetn ( net_gnd0 ),
      .s3_axi_awid ( net_gnd4[0:3] ),
      .s3_axi_awaddr ( net_gnd32[0:31] ),
      .s3_axi_awlen ( net_gnd8 ),
      .s3_axi_awsize ( net_gnd3[0:2] ),
      .s3_axi_awburst ( net_gnd2 ),
      .s3_axi_awlock ( net_gnd1[0:0] ),
      .s3_axi_awcache ( net_gnd4[0:3] ),
      .s3_axi_awprot ( net_gnd3[0:2] ),
      .s3_axi_awqos ( net_gnd4[0:3] ),
      .s3_axi_awvalid ( net_gnd0 ),
      .s3_axi_awready (  ),
      .s3_axi_wdata ( net_gnd32[0:31] ),
      .s3_axi_wstrb ( net_gnd4[0:3] ),
      .s3_axi_wlast ( net_gnd0 ),
      .s3_axi_wvalid ( net_gnd0 ),
      .s3_axi_wready (  ),
      .s3_axi_bid (  ),
      .s3_axi_bresp (  ),
      .s3_axi_bvalid (  ),
      .s3_axi_bready ( net_gnd0 ),
      .s3_axi_arid ( net_gnd4[0:3] ),
      .s3_axi_araddr ( net_gnd32[0:31] ),
      .s3_axi_arlen ( net_gnd8 ),
      .s3_axi_arsize ( net_gnd3[0:2] ),
      .s3_axi_arburst ( net_gnd2 ),
      .s3_axi_arlock ( net_gnd1[0:0] ),
      .s3_axi_arcache ( net_gnd4[0:3] ),
      .s3_axi_arprot ( net_gnd3[0:2] ),
      .s3_axi_arqos ( net_gnd4[0:3] ),
      .s3_axi_arvalid ( net_gnd0 ),
      .s3_axi_arready (  ),
      .s3_axi_rid (  ),
      .s3_axi_rdata (  ),
      .s3_axi_rresp (  ),
      .s3_axi_rlast (  ),
      .s3_axi_rvalid (  ),
      .s3_axi_rready ( net_gnd0 ),
      .s4_axi_aclk ( net_gnd0 ),
      .s4_axi_aresetn ( net_gnd0 ),
      .s4_axi_awid ( net_gnd4[0:3] ),
      .s4_axi_awaddr ( net_gnd32[0:31] ),
      .s4_axi_awlen ( net_gnd8 ),
      .s4_axi_awsize ( net_gnd3[0:2] ),
      .s4_axi_awburst ( net_gnd2 ),
      .s4_axi_awlock ( net_gnd1[0:0] ),
      .s4_axi_awcache ( net_gnd4[0:3] ),
      .s4_axi_awprot ( net_gnd3[0:2] ),
      .s4_axi_awqos ( net_gnd4[0:3] ),
      .s4_axi_awvalid ( net_gnd0 ),
      .s4_axi_awready (  ),
      .s4_axi_wdata ( net_gnd32[0:31] ),
      .s4_axi_wstrb ( net_gnd4[0:3] ),
      .s4_axi_wlast ( net_gnd0 ),
      .s4_axi_wvalid ( net_gnd0 ),
      .s4_axi_wready (  ),
      .s4_axi_bid (  ),
      .s4_axi_bresp (  ),
      .s4_axi_bvalid (  ),
      .s4_axi_bready ( net_gnd0 ),
      .s4_axi_arid ( net_gnd4[0:3] ),
      .s4_axi_araddr ( net_gnd32[0:31] ),
      .s4_axi_arlen ( net_gnd8 ),
      .s4_axi_arsize ( net_gnd3[0:2] ),
      .s4_axi_arburst ( net_gnd2 ),
      .s4_axi_arlock ( net_gnd1[0:0] ),
      .s4_axi_arcache ( net_gnd4[0:3] ),
      .s4_axi_arprot ( net_gnd3[0:2] ),
      .s4_axi_arqos ( net_gnd4[0:3] ),
      .s4_axi_arvalid ( net_gnd0 ),
      .s4_axi_arready (  ),
      .s4_axi_rid (  ),
      .s4_axi_rdata (  ),
      .s4_axi_rresp (  ),
      .s4_axi_rlast (  ),
      .s4_axi_rvalid (  ),
      .s4_axi_rready ( net_gnd0 ),
      .s5_axi_aclk ( net_gnd0 ),
      .s5_axi_aresetn ( net_gnd0 ),
      .s5_axi_awid ( net_gnd4[0:3] ),
      .s5_axi_awaddr ( net_gnd32[0:31] ),
      .s5_axi_awlen ( net_gnd8 ),
      .s5_axi_awsize ( net_gnd3[0:2] ),
      .s5_axi_awburst ( net_gnd2 ),
      .s5_axi_awlock ( net_gnd1[0:0] ),
      .s5_axi_awcache ( net_gnd4[0:3] ),
      .s5_axi_awprot ( net_gnd3[0:2] ),
      .s5_axi_awqos ( net_gnd4[0:3] ),
      .s5_axi_awvalid ( net_gnd0 ),
      .s5_axi_awready (  ),
      .s5_axi_wdata ( net_gnd32[0:31] ),
      .s5_axi_wstrb ( net_gnd4[0:3] ),
      .s5_axi_wlast ( net_gnd0 ),
      .s5_axi_wvalid ( net_gnd0 ),
      .s5_axi_wready (  ),
      .s5_axi_bid (  ),
      .s5_axi_bresp (  ),
      .s5_axi_bvalid (  ),
      .s5_axi_bready ( net_gnd0 ),
      .s5_axi_arid ( net_gnd4[0:3] ),
      .s5_axi_araddr ( net_gnd32[0:31] ),
      .s5_axi_arlen ( net_gnd8 ),
      .s5_axi_arsize ( net_gnd3[0:2] ),
      .s5_axi_arburst ( net_gnd2 ),
      .s5_axi_arlock ( net_gnd1[0:0] ),
      .s5_axi_arcache ( net_gnd4[0:3] ),
      .s5_axi_arprot ( net_gnd3[0:2] ),
      .s5_axi_arqos ( net_gnd4[0:3] ),
      .s5_axi_arvalid ( net_gnd0 ),
      .s5_axi_arready (  ),
      .s5_axi_rid (  ),
      .s5_axi_rdata (  ),
      .s5_axi_rresp (  ),
      .s5_axi_rlast (  ),
      .s5_axi_rvalid (  ),
      .s5_axi_rready ( net_gnd0 )
    );

  linear_flash_wrapper
    Linear_Flash (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[6] ),
      .S_AXI_REG_AWADDR ( net_gnd32[0:31] ),
      .S_AXI_REG_AWVALID ( net_gnd0 ),
      .S_AXI_REG_AWREADY (  ),
      .S_AXI_REG_WDATA ( net_gnd32[0:31] ),
      .S_AXI_REG_WSTRB ( net_gnd4[0:3] ),
      .S_AXI_REG_WVALID ( net_gnd0 ),
      .S_AXI_REG_WREADY (  ),
      .S_AXI_REG_BRESP (  ),
      .S_AXI_REG_BVALID (  ),
      .S_AXI_REG_BREADY ( net_gnd0 ),
      .S_AXI_REG_ARADDR ( net_gnd32[0:31] ),
      .S_AXI_REG_ARVALID ( net_gnd0 ),
      .S_AXI_REG_ARREADY (  ),
      .S_AXI_REG_RDATA (  ),
      .S_AXI_REG_RRESP (  ),
      .S_AXI_REG_RVALID (  ),
      .S_AXI_REG_RREADY ( net_gnd0 ),
      .S_AXI_MEM_AWLEN ( axi4lite_0_M_AWLEN[55:48] ),
      .S_AXI_MEM_AWSIZE ( axi4lite_0_M_AWSIZE[20:18] ),
      .S_AXI_MEM_AWBURST ( axi4lite_0_M_AWBURST[13:12] ),
      .S_AXI_MEM_AWLOCK ( axi4lite_0_M_AWLOCK[12] ),
      .S_AXI_MEM_AWCACHE ( axi4lite_0_M_AWCACHE[27:24] ),
      .S_AXI_MEM_AWPROT ( axi4lite_0_M_AWPROT[20:18] ),
      .S_AXI_MEM_WLAST ( axi4lite_0_M_WLAST[6] ),
      .S_AXI_MEM_BID ( axi4lite_0_M_BID[6:6] ),
      .S_AXI_MEM_ARID ( axi4lite_0_M_ARID[6:6] ),
      .S_AXI_MEM_ARLEN ( axi4lite_0_M_ARLEN[55:48] ),
      .S_AXI_MEM_ARSIZE ( axi4lite_0_M_ARSIZE[20:18] ),
      .S_AXI_MEM_ARBURST ( axi4lite_0_M_ARBURST[13:12] ),
      .S_AXI_MEM_ARLOCK ( axi4lite_0_M_ARLOCK[12] ),
      .S_AXI_MEM_ARCACHE ( axi4lite_0_M_ARCACHE[27:24] ),
      .S_AXI_MEM_ARPROT ( axi4lite_0_M_ARPROT[20:18] ),
      .S_AXI_MEM_RID ( axi4lite_0_M_RID[6:6] ),
      .S_AXI_MEM_RLAST ( axi4lite_0_M_RLAST[6] ),
      .S_AXI_MEM_AWID ( axi4lite_0_M_AWID[6:6] ),
      .S_AXI_MEM_AWADDR ( axi4lite_0_M_AWADDR[223:192] ),
      .S_AXI_MEM_AWVALID ( axi4lite_0_M_AWVALID[6] ),
      .S_AXI_MEM_AWREADY ( axi4lite_0_M_AWREADY[6] ),
      .S_AXI_MEM_WDATA ( axi4lite_0_M_WDATA[223:192] ),
      .S_AXI_MEM_WSTRB ( axi4lite_0_M_WSTRB[27:24] ),
      .S_AXI_MEM_WVALID ( axi4lite_0_M_WVALID[6] ),
      .S_AXI_MEM_WREADY ( axi4lite_0_M_WREADY[6] ),
      .S_AXI_MEM_BRESP ( axi4lite_0_M_BRESP[13:12] ),
      .S_AXI_MEM_BVALID ( axi4lite_0_M_BVALID[6] ),
      .S_AXI_MEM_BREADY ( axi4lite_0_M_BREADY[6] ),
      .S_AXI_MEM_ARADDR ( axi4lite_0_M_ARADDR[223:192] ),
      .S_AXI_MEM_ARVALID ( axi4lite_0_M_ARVALID[6] ),
      .S_AXI_MEM_ARREADY ( axi4lite_0_M_ARREADY[6] ),
      .S_AXI_MEM_RDATA ( axi4lite_0_M_RDATA[223:192] ),
      .S_AXI_MEM_RRESP ( axi4lite_0_M_RRESP[13:12] ),
      .S_AXI_MEM_RVALID ( axi4lite_0_M_RVALID[6] ),
      .S_AXI_MEM_RREADY ( axi4lite_0_M_RREADY[6] ),
      .RdClk ( clk_100_0000MHzPLL0[0] ),
      .Mem_A ( pgassign9 ),
      .Mem_RPN ( Linear_Flash_reset ),
      .Mem_CE (  ),
      .Mem_CEN ( pgassign2[0:0] ),
      .Mem_OEN ( pgassign1[0:0] ),
      .Mem_WEN ( Linear_Flash_we_n ),
      .Mem_QWEN (  ),
      .Mem_BEN (  ),
      .Mem_ADV_LDN (  ),
      .Mem_LBON (  ),
      .Mem_CKEN (  ),
      .Mem_CRE (  ),
      .Mem_RNW (  ),
      .Mem_DQ_I ( Linear_Flash_data_I[0:15] ),
      .Mem_DQ_O ( Linear_Flash_data_O[0:15] ),
      .Mem_DQ_T ( Linear_Flash_data_T[0:15] ),
      .MEM_DQ_PARITY_I ( net_gnd2 ),
      .MEM_DQ_PARITY_O (  ),
      .MEM_DQ_PARITY_T (  )
    );

  leds_8bits_wrapper
    LEDs_8Bits (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[7] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[255:224] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[7] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[7] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[255:224] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[31:28] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[7] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[7] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[15:14] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[7] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[7] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[255:224] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[7] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[7] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[255:224] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[15:14] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[7] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[7] ),
      .IP2INTC_Irpt (  ),
      .GPIO_IO_I ( net_gnd8 ),
      .GPIO_IO_O ( LEDs_8Bits_TRI_O ),
      .GPIO_IO_T (  ),
      .GPIO2_IO_I ( net_gnd32[0:31] ),
      .GPIO2_IO_O (  ),
      .GPIO2_IO_T (  )
    );

  ethernet_lite_wrapper
    Ethernet_Lite (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[8] ),
      .IP2INTC_Irpt ( Ethernet_Lite_IP2INTC_Irpt ),
      .S_AXI_AWID ( axi4lite_0_M_AWID[8:8] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[287:256] ),
      .S_AXI_AWLEN ( axi4lite_0_M_AWLEN[71:64] ),
      .S_AXI_AWSIZE ( axi4lite_0_M_AWSIZE[26:24] ),
      .S_AXI_AWBURST ( axi4lite_0_M_AWBURST[17:16] ),
      .S_AXI_AWCACHE ( axi4lite_0_M_AWCACHE[35:32] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[8] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[8] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[287:256] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[35:32] ),
      .S_AXI_WLAST ( axi4lite_0_M_WLAST[8] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[8] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[8] ),
      .S_AXI_BID ( axi4lite_0_M_BID[8:8] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[17:16] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[8] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[8] ),
      .S_AXI_ARID ( axi4lite_0_M_ARID[8:8] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[287:256] ),
      .S_AXI_ARLEN ( axi4lite_0_M_ARLEN[71:64] ),
      .S_AXI_ARSIZE ( axi4lite_0_M_ARSIZE[26:24] ),
      .S_AXI_ARBURST ( axi4lite_0_M_ARBURST[17:16] ),
      .S_AXI_ARCACHE ( axi4lite_0_M_ARCACHE[35:32] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[8] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[8] ),
      .S_AXI_RID ( axi4lite_0_M_RID[8:8] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[287:256] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[17:16] ),
      .S_AXI_RLAST ( axi4lite_0_M_RLAST[8] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[8] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[8] ),
      .PHY_tx_clk ( Ethernet_Lite_TX_CLK ),
      .PHY_rx_clk ( Ethernet_Lite_RX_CLK ),
      .PHY_crs ( Ethernet_Lite_CRS ),
      .PHY_dv ( Ethernet_Lite_RX_DV ),
      .PHY_rx_data ( Ethernet_Lite_RXD ),
      .PHY_col ( Ethernet_Lite_COL ),
      .PHY_rx_er ( Ethernet_Lite_RX_ER ),
      .PHY_rst_n ( Ethernet_Lite_PHY_RST_N ),
      .PHY_tx_en ( Ethernet_Lite_TX_EN ),
      .PHY_tx_data ( Ethernet_Lite_TXD ),
      .PHY_MDC ( Ethernet_Lite_MDC ),
      .PHY_MDIO_I ( Ethernet_Lite_MDIO_I ),
      .PHY_MDIO_O ( Ethernet_Lite_MDIO_O ),
      .PHY_MDIO_T ( Ethernet_Lite_MDIO_T )
    );

  dip_switches_8bits_wrapper
    DIP_Switches_8Bits (
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[9] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[319:288] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[9] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[9] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[319:288] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[39:36] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[9] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[9] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[19:18] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[9] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[9] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[319:288] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[9] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[9] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[319:288] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[19:18] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[9] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[9] ),
      .IP2INTC_Irpt (  ),
      .GPIO_IO_I ( DIP_Switches_8Bits_TRI_I ),
      .GPIO_IO_O (  ),
      .GPIO_IO_T (  ),
      .GPIO2_IO_I ( net_gnd32[0:31] ),
      .GPIO2_IO_O (  ),
      .GPIO2_IO_T (  )
    );

  axi_bram_ctrl_0_wrapper
    axi_bram_ctrl_0 (
      .ECC_Interrupt (  ),
      .ECC_UE (  ),
      .S_AXI_ACLK ( clk_100_0000MHzPLL0[0] ),
      .S_AXI_ARESETN ( axi4lite_0_M_ARESETN[10] ),
      .S_AXI_AWID ( axi4lite_0_M_AWID[10:10] ),
      .S_AXI_AWADDR ( axi4lite_0_M_AWADDR[351:320] ),
      .S_AXI_AWLEN ( axi4lite_0_M_AWLEN[87:80] ),
      .S_AXI_AWSIZE ( axi4lite_0_M_AWSIZE[32:30] ),
      .S_AXI_AWBURST ( axi4lite_0_M_AWBURST[21:20] ),
      .S_AXI_AWLOCK ( axi4lite_0_M_AWLOCK[20] ),
      .S_AXI_AWCACHE ( axi4lite_0_M_AWCACHE[43:40] ),
      .S_AXI_AWPROT ( axi4lite_0_M_AWPROT[32:30] ),
      .S_AXI_AWVALID ( axi4lite_0_M_AWVALID[10] ),
      .S_AXI_AWREADY ( axi4lite_0_M_AWREADY[10] ),
      .S_AXI_WDATA ( axi4lite_0_M_WDATA[351:320] ),
      .S_AXI_WSTRB ( axi4lite_0_M_WSTRB[43:40] ),
      .S_AXI_WLAST ( axi4lite_0_M_WLAST[10] ),
      .S_AXI_WVALID ( axi4lite_0_M_WVALID[10] ),
      .S_AXI_WREADY ( axi4lite_0_M_WREADY[10] ),
      .S_AXI_BID ( axi4lite_0_M_BID[10:10] ),
      .S_AXI_BRESP ( axi4lite_0_M_BRESP[21:20] ),
      .S_AXI_BVALID ( axi4lite_0_M_BVALID[10] ),
      .S_AXI_BREADY ( axi4lite_0_M_BREADY[10] ),
      .S_AXI_ARID ( axi4lite_0_M_ARID[10:10] ),
      .S_AXI_ARADDR ( axi4lite_0_M_ARADDR[351:320] ),
      .S_AXI_ARLEN ( axi4lite_0_M_ARLEN[87:80] ),
      .S_AXI_ARSIZE ( axi4lite_0_M_ARSIZE[32:30] ),
      .S_AXI_ARBURST ( axi4lite_0_M_ARBURST[21:20] ),
      .S_AXI_ARLOCK ( axi4lite_0_M_ARLOCK[20] ),
      .S_AXI_ARCACHE ( axi4lite_0_M_ARCACHE[43:40] ),
      .S_AXI_ARPROT ( axi4lite_0_M_ARPROT[32:30] ),
      .S_AXI_ARVALID ( axi4lite_0_M_ARVALID[10] ),
      .S_AXI_ARREADY ( axi4lite_0_M_ARREADY[10] ),
      .S_AXI_RID ( axi4lite_0_M_RID[10:10] ),
      .S_AXI_RDATA ( axi4lite_0_M_RDATA[351:320] ),
      .S_AXI_RRESP ( axi4lite_0_M_RRESP[21:20] ),
      .S_AXI_RVALID ( axi4lite_0_M_RVALID[10] ),
      .S_AXI_RREADY ( axi4lite_0_M_RREADY[10] ),
      .S_AXI_RLAST ( axi4lite_0_M_RLAST[10] ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_AWADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32[0:31] ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_ARADDR ( net_gnd32[0:31] ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .BRAM_Rst_A ( axi_bram_ctrl_0_BRAM_Rst_A ),
      .BRAM_Clk_A ( axi_bram_ctrl_0_BRAM_Clk_A ),
      .BRAM_En_A ( axi_bram_ctrl_0_BRAM_En_A ),
      .BRAM_WE_A ( axi_bram_ctrl_0_BRAM_WE_A ),
      .BRAM_Addr_A ( axi_bram_ctrl_0_BRAM_Addr_A ),
      .BRAM_WrData_A ( axi_bram_ctrl_0_BRAM_WrData_A ),
      .BRAM_RdData_A ( axi_bram_ctrl_0_BRAM_RdData_A ),
      .BRAM_Rst_B (  ),
      .BRAM_Clk_B (  ),
      .BRAM_En_B (  ),
      .BRAM_WE_B (  ),
      .BRAM_Addr_B (  ),
      .BRAM_WrData_B (  ),
      .BRAM_RdData_B ( net_gnd32[0:31] )
    );

  IOBUF
    iobuf_0 (
      .I ( Linear_Flash_data_O[0] ),
      .IO ( Linear_Flash_data[0] ),
      .O ( Linear_Flash_data_I[0] ),
      .T ( Linear_Flash_data_T[0] )
    );

  IOBUF
    iobuf_1 (
      .I ( Linear_Flash_data_O[1] ),
      .IO ( Linear_Flash_data[1] ),
      .O ( Linear_Flash_data_I[1] ),
      .T ( Linear_Flash_data_T[1] )
    );

  IOBUF
    iobuf_2 (
      .I ( Linear_Flash_data_O[2] ),
      .IO ( Linear_Flash_data[2] ),
      .O ( Linear_Flash_data_I[2] ),
      .T ( Linear_Flash_data_T[2] )
    );

  IOBUF
    iobuf_3 (
      .I ( Linear_Flash_data_O[3] ),
      .IO ( Linear_Flash_data[3] ),
      .O ( Linear_Flash_data_I[3] ),
      .T ( Linear_Flash_data_T[3] )
    );

  IOBUF
    iobuf_4 (
      .I ( Linear_Flash_data_O[4] ),
      .IO ( Linear_Flash_data[4] ),
      .O ( Linear_Flash_data_I[4] ),
      .T ( Linear_Flash_data_T[4] )
    );

  IOBUF
    iobuf_5 (
      .I ( Linear_Flash_data_O[5] ),
      .IO ( Linear_Flash_data[5] ),
      .O ( Linear_Flash_data_I[5] ),
      .T ( Linear_Flash_data_T[5] )
    );

  IOBUF
    iobuf_6 (
      .I ( Linear_Flash_data_O[6] ),
      .IO ( Linear_Flash_data[6] ),
      .O ( Linear_Flash_data_I[6] ),
      .T ( Linear_Flash_data_T[6] )
    );

  IOBUF
    iobuf_7 (
      .I ( Linear_Flash_data_O[7] ),
      .IO ( Linear_Flash_data[7] ),
      .O ( Linear_Flash_data_I[7] ),
      .T ( Linear_Flash_data_T[7] )
    );

  IOBUF
    iobuf_8 (
      .I ( Linear_Flash_data_O[8] ),
      .IO ( Linear_Flash_data[8] ),
      .O ( Linear_Flash_data_I[8] ),
      .T ( Linear_Flash_data_T[8] )
    );

  IOBUF
    iobuf_9 (
      .I ( Linear_Flash_data_O[9] ),
      .IO ( Linear_Flash_data[9] ),
      .O ( Linear_Flash_data_I[9] ),
      .T ( Linear_Flash_data_T[9] )
    );

  IOBUF
    iobuf_10 (
      .I ( Linear_Flash_data_O[10] ),
      .IO ( Linear_Flash_data[10] ),
      .O ( Linear_Flash_data_I[10] ),
      .T ( Linear_Flash_data_T[10] )
    );

  IOBUF
    iobuf_11 (
      .I ( Linear_Flash_data_O[11] ),
      .IO ( Linear_Flash_data[11] ),
      .O ( Linear_Flash_data_I[11] ),
      .T ( Linear_Flash_data_T[11] )
    );

  IOBUF
    iobuf_12 (
      .I ( Linear_Flash_data_O[12] ),
      .IO ( Linear_Flash_data[12] ),
      .O ( Linear_Flash_data_I[12] ),
      .T ( Linear_Flash_data_T[12] )
    );

  IOBUF
    iobuf_13 (
      .I ( Linear_Flash_data_O[13] ),
      .IO ( Linear_Flash_data[13] ),
      .O ( Linear_Flash_data_I[13] ),
      .T ( Linear_Flash_data_T[13] )
    );

  IOBUF
    iobuf_14 (
      .I ( Linear_Flash_data_O[14] ),
      .IO ( Linear_Flash_data[14] ),
      .O ( Linear_Flash_data_I[14] ),
      .T ( Linear_Flash_data_T[14] )
    );

  IOBUF
    iobuf_15 (
      .I ( Linear_Flash_data_O[15] ),
      .IO ( Linear_Flash_data[15] ),
      .O ( Linear_Flash_data_I[15] ),
      .T ( Linear_Flash_data_T[15] )
    );

  IOBUF
    iobuf_16 (
      .I ( Ethernet_Lite_MDIO_O ),
      .IO ( Ethernet_Lite_MDIO ),
      .O ( Ethernet_Lite_MDIO_I ),
      .T ( Ethernet_Lite_MDIO_T )
    );

endmodule

