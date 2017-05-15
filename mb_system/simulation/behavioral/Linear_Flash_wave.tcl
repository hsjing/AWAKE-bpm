#  Simulation Model Generator
#  Xilinx EDK 13.3 EDK_O.76xd
#  Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
#
#  File     Linear_Flash_wave.tcl (Mon Mar 07 16:24:29 2016)
#
#  Module   linear_flash_wrapper
#  Instance Linear_Flash
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "mb_system_tb${ps}dut" }

# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_ACLK -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_ARESETN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_AWADDR -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_AWVALID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_AWREADY -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_WDATA -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_WSTRB -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_WVALID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_WREADY -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_BRESP -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_BVALID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_BREADY -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_ARADDR -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_ARVALID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_ARREADY -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_RDATA -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_RRESP -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_RVALID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_REG_RREADY -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWLEN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWSIZE -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWBURST -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWLOCK -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWCACHE -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWPROT -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_WLAST -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_BID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARLEN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARSIZE -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARBURST -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARLOCK -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARCACHE -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARPROT -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_RID -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_RLAST -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWADDR -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWVALID -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_AWREADY -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_WDATA -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_WSTRB -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_WVALID -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_WREADY -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_BRESP -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_BVALID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_BREADY -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARADDR -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARVALID -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_ARREADY -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_RDATA -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_RRESP -into $id
  wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_RVALID -into $id
# wave add $tbpath${ps}Linear_Flash${ps}S_AXI_MEM_RREADY -into $id
  wave add $tbpath${ps}Linear_Flash${ps}RdClk -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_A -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_RPN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_CE -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_CEN -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_OEN -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_WEN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_QWEN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_BEN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_ADV_LDN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_LBON -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_CKEN -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_CRE -into $id
# wave add $tbpath${ps}Linear_Flash${ps}Mem_RNW -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_DQ_I -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_DQ_O -into $id
  wave add $tbpath${ps}Linear_Flash${ps}Mem_DQ_T -into $id
  wave add $tbpath${ps}Linear_Flash${ps}MEM_DQ_PARITY_I -into $id
# wave add $tbpath${ps}Linear_Flash${ps}MEM_DQ_PARITY_O -into $id
# wave add $tbpath${ps}Linear_Flash${ps}MEM_DQ_PARITY_T -into $id

