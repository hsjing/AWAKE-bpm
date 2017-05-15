///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017 Xilinx, Inc.
// All Rights Reserved
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor     : Xilinx
// \   \   \/     Version    : 13.3
//  \   \         Application: Xilinx CORE Generator
//  /   /         Filename   : ila_trig8.v
// /___/   /\     Timestamp  : Fri Mar 24 11:54:25 Pacific Daylight Time 2017
// \   \  /  \
//  \___\/\___\
//
// Design Name: Verilog Synthesis Wrapper
///////////////////////////////////////////////////////////////////////////////
// This wrapper is used to integrate with Project Navigator and PlanAhead

`timescale 1ns/1ps

module ila_trig8(
    CONTROL,
    CLK,
    DATA,
    TRIG0);


inout [35 : 0] CONTROL;
input CLK;
input [63 : 0] DATA;
input [7 : 0] TRIG0;

endmodule
