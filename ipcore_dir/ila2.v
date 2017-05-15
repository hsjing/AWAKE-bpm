///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2016 Xilinx, Inc.
// All Rights Reserved
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor     : Xilinx
// \   \   \/     Version    : 13.3
//  \   \         Application: Xilinx CORE Generator
//  /   /         Filename   : ila2.v
// /___/   /\     Timestamp  : Thu Feb 11 16:14:21 Pacific Standard Time 2016
// \   \  /  \
//  \___\/\___\
//
// Design Name: Verilog Synthesis Wrapper
///////////////////////////////////////////////////////////////////////////////
// This wrapper is used to integrate with Project Navigator and PlanAhead

`timescale 1ns/1ps

module ila2(
    CONTROL,
    CLK,
    DATA,
    TRIG0);


inout [35 : 0] CONTROL;
input CLK;
input [63 : 0] DATA;
input [0 : 0] TRIG0;

endmodule
