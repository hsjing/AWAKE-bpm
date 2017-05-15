////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: O.76xd
//  \   \         Application: netgen
//  /   /         Filename: fix_float.v
// /___/   /\     Timestamp: Tue Mar 15 02:21:32 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Xilinx/MyXilinx/LX150T/Awake_BPM_Sync_digitizer_v1/awake/ipcore_dir/tmp/_cg/fix_float.ngc C:/Xilinx/MyXilinx/LX150T/Awake_BPM_Sync_digitizer_v1/awake/ipcore_dir/tmp/_cg/fix_float.v 
// Device	: 6slx150tfgg676-3
// Input file	: C:/Xilinx/MyXilinx/LX150T/Awake_BPM_Sync_digitizer_v1/awake/ipcore_dir/tmp/_cg/fix_float.ngc
// Output file	: C:/Xilinx/MyXilinx/LX150T/Awake_BPM_Sync_digitizer_v1/awake/ipcore_dir/tmp/_cg/fix_float.v
// # of Modules	: 1
// Design Name	: fix_float
// Xilinx        : C:\Xilinx\13.3\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module fix_float (
  operation_nd, operation_rfd, rdy, a, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  output operation_rfd;
  output rdy;
  input [15 : 0] a;
  output [31 : 0] result;
  
  // synthesis translate_off
  
  wire \NlwRenamedSignal_result[31] ;
  wire NlwRenamedSignal_rdy;
  wire \NlwRenamedSignal_result[27] ;
  wire NlwRenamedSig_OI_operation_rfd;
  wire sig00000001;
  wire sig00000002;
  wire sig00000003;
  wire sig00000004;
  wire sig00000005;
  wire sig00000006;
  wire sig00000007;
  wire sig00000008;
  wire sig00000009;
  wire sig0000000a;
  wire sig0000000b;
  wire sig0000000c;
  wire sig0000000d;
  wire sig0000000e;
  wire sig0000000f;
  wire sig00000010;
  wire sig00000011;
  wire sig00000012;
  wire sig00000013;
  wire sig00000014;
  wire sig00000015;
  wire sig00000016;
  wire sig00000017;
  wire sig00000018;
  wire sig00000019;
  wire sig0000001a;
  wire sig0000001b;
  wire sig0000001c;
  wire sig0000001d;
  wire sig0000001e;
  wire sig0000001f;
  wire sig00000020;
  wire sig00000021;
  wire sig00000022;
  wire sig00000023;
  wire sig00000024;
  wire sig00000025;
  wire sig00000026;
  wire sig00000027;
  wire sig00000028;
  wire sig00000029;
  wire sig0000002a;
  wire sig0000002b;
  wire sig0000002c;
  wire sig0000002d;
  wire sig0000002e;
  wire sig0000002f;
  wire sig00000030;
  wire sig00000031;
  wire sig00000032;
  wire sig00000033;
  wire sig00000034;
  wire sig00000035;
  wire sig00000036;
  wire sig00000037;
  wire sig00000038;
  wire sig00000039;
  wire sig0000003a;
  wire sig0000003b;
  wire sig0000003c;
  wire sig0000003d;
  wire sig0000003e;
  wire sig0000003f;
  wire sig00000040;
  wire sig00000041;
  wire sig00000042;
  wire sig00000043;
  wire sig00000044;
  wire sig00000045;
  wire sig00000046;
  wire sig00000047;
  wire sig00000048;
  wire sig00000049;
  wire sig0000004a;
  wire sig0000004b;
  wire sig0000004c;
  wire sig0000004d;
  wire sig0000004e;
  wire sig0000004f;
  wire sig00000050;
  wire sig00000051;
  wire sig00000052;
  wire sig00000053;
  wire sig00000054;
  wire sig00000055;
  wire sig00000056;
  wire sig00000057;
  wire sig00000058;
  wire sig00000059;
  wire sig0000005a;
  wire sig0000005b;
  wire sig0000005c;
  wire sig0000005d;
  wire sig0000005e;
  wire sig0000005f;
  wire sig00000060;
  wire sig00000061;
  wire sig00000062;
  wire sig00000063;
  wire sig00000064;
  wire sig00000065;
  wire sig00000066;
  wire sig00000067;
  wire sig00000068;
  wire sig00000069;
  wire sig0000006a;
  wire sig0000006b;
  wire sig0000006c;
  wire sig0000006d;
  wire sig0000006e;
  wire sig0000006f;
  wire sig00000070;
  wire sig00000071;
  wire sig00000072;
  wire sig00000073;
  wire sig00000074;
  wire sig00000075;
  wire sig00000076;
  wire sig00000077;
  wire sig00000078;
  wire sig00000079;
  wire sig0000007a;
  wire sig0000007b;
  wire sig0000007c;
  wire sig0000007d;
  wire sig0000007e;
  wire sig0000007f;
  wire sig00000080;
  wire sig00000081;
  wire sig00000082;
  wire sig00000083;
  wire sig00000084;
  wire sig00000085;
  wire sig00000086;
  wire sig00000087;
  wire sig00000088;
  wire sig00000089;
  wire sig0000008a;
  wire sig0000008b;
  wire sig0000008c;
  wire sig0000008d;
  wire sig0000008e;
  wire sig0000008f;
  wire sig00000090;
  wire sig00000091;
  wire sig00000092;
  wire sig00000093;
  wire sig00000094;
  wire sig00000095;
  wire sig00000096;
  wire sig00000097;
  wire sig00000098;
  wire sig00000099;
  wire sig0000009a;
  wire NLW_blk00000025_O_UNCONNECTED;
  assign
    \NlwRenamedSignal_result[31]  = a[15],
    NlwRenamedSignal_rdy = operation_nd,
    result[31] = \NlwRenamedSignal_result[31] ,
    result[29] = \NlwRenamedSignal_result[27] ,
    result[27] = \NlwRenamedSignal_result[27] ,
    operation_rfd = NlwRenamedSig_OI_operation_rfd,
    rdy = NlwRenamedSignal_rdy;
  VCC   blk00000001 (
    .P(NlwRenamedSig_OI_operation_rfd)
  );
  GND   blk00000002 (
    .G(sig00000001)
  );
  MUXCY   blk00000003 (
    .CI(sig0000000f),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig00000011)
  );
  MUXCY   blk00000004 (
    .CI(sig00000010),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000000f)
  );
  MUXCY   blk00000005 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000010)
  );
  XORCY   blk00000006 (
    .CI(sig0000005e),
    .LI(sig00000001),
    .O(sig0000004e)
  );
  XORCY   blk00000007 (
    .CI(sig0000005f),
    .LI(sig0000005d),
    .O(sig0000004d)
  );
  MUXCY   blk00000008 (
    .CI(sig0000005f),
    .DI(sig00000001),
    .S(sig0000005d),
    .O(sig0000005e)
  );
  XORCY   blk00000009 (
    .CI(sig00000060),
    .LI(sig0000005c),
    .O(sig0000004c)
  );
  MUXCY   blk0000000a (
    .CI(sig00000060),
    .DI(sig00000001),
    .S(sig0000005c),
    .O(sig0000005f)
  );
  XORCY   blk0000000b (
    .CI(sig00000061),
    .LI(sig0000005b),
    .O(sig0000004b)
  );
  MUXCY   blk0000000c (
    .CI(sig00000061),
    .DI(sig00000001),
    .S(sig0000005b),
    .O(sig00000060)
  );
  XORCY   blk0000000d (
    .CI(sig00000062),
    .LI(sig0000005a),
    .O(sig0000004a)
  );
  MUXCY   blk0000000e (
    .CI(sig00000062),
    .DI(sig00000001),
    .S(sig0000005a),
    .O(sig00000061)
  );
  XORCY   blk0000000f (
    .CI(sig00000063),
    .LI(sig00000059),
    .O(sig00000049)
  );
  MUXCY   blk00000010 (
    .CI(sig00000063),
    .DI(sig00000001),
    .S(sig00000059),
    .O(sig00000062)
  );
  XORCY   blk00000011 (
    .CI(sig00000064),
    .LI(sig00000058),
    .O(sig00000048)
  );
  MUXCY   blk00000012 (
    .CI(sig00000064),
    .DI(sig00000001),
    .S(sig00000058),
    .O(sig00000063)
  );
  XORCY   blk00000013 (
    .CI(sig00000065),
    .LI(sig00000057),
    .O(sig00000047)
  );
  MUXCY   blk00000014 (
    .CI(sig00000065),
    .DI(sig00000001),
    .S(sig00000057),
    .O(sig00000064)
  );
  XORCY   blk00000015 (
    .CI(sig00000066),
    .LI(sig00000056),
    .O(sig00000046)
  );
  MUXCY   blk00000016 (
    .CI(sig00000066),
    .DI(sig00000001),
    .S(sig00000056),
    .O(sig00000065)
  );
  XORCY   blk00000017 (
    .CI(sig00000067),
    .LI(sig00000055),
    .O(sig00000045)
  );
  MUXCY   blk00000018 (
    .CI(sig00000067),
    .DI(sig00000001),
    .S(sig00000055),
    .O(sig00000066)
  );
  XORCY   blk00000019 (
    .CI(sig00000068),
    .LI(sig00000054),
    .O(sig00000044)
  );
  MUXCY   blk0000001a (
    .CI(sig00000068),
    .DI(sig00000001),
    .S(sig00000054),
    .O(sig00000067)
  );
  XORCY   blk0000001b (
    .CI(sig00000069),
    .LI(sig00000053),
    .O(sig00000043)
  );
  MUXCY   blk0000001c (
    .CI(sig00000069),
    .DI(sig00000001),
    .S(sig00000053),
    .O(sig00000068)
  );
  XORCY   blk0000001d (
    .CI(sig0000006a),
    .LI(sig00000052),
    .O(sig00000042)
  );
  MUXCY   blk0000001e (
    .CI(sig0000006a),
    .DI(sig00000001),
    .S(sig00000052),
    .O(sig00000069)
  );
  XORCY   blk0000001f (
    .CI(sig0000006b),
    .LI(sig00000051),
    .O(sig00000041)
  );
  MUXCY   blk00000020 (
    .CI(sig0000006b),
    .DI(sig00000001),
    .S(sig00000051),
    .O(sig0000006a)
  );
  XORCY   blk00000021 (
    .CI(sig0000006c),
    .LI(sig00000050),
    .O(sig00000040)
  );
  MUXCY   blk00000022 (
    .CI(sig0000006c),
    .DI(sig00000001),
    .S(sig00000050),
    .O(sig0000006b)
  );
  XORCY   blk00000023 (
    .CI(\NlwRenamedSignal_result[31] ),
    .LI(sig0000004f),
    .O(sig0000003f)
  );
  MUXCY   blk00000024 (
    .CI(\NlwRenamedSignal_result[31] ),
    .DI(sig00000001),
    .S(sig0000004f),
    .O(sig0000006c)
  );
  MUXF7   blk00000025 (
    .I0(sig0000006d),
    .I1(sig0000006e),
    .S(sig00000015),
    .O(NLW_blk00000025_O_UNCONNECTED)
  );
  MUXCY   blk00000026 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000078),
    .O(sig00000075)
  );
  MUXCY   blk00000027 (
    .CI(sig00000075),
    .DI(sig00000001),
    .S(sig00000079),
    .O(sig00000074)
  );
  MUXCY   blk00000028 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000076),
    .O(sig00000073)
  );
  MUXCY   blk00000029 (
    .CI(sig00000073),
    .DI(sig00000001),
    .S(sig00000077),
    .O(sig00000015)
  );
  MUXF7   blk0000002a (
    .I0(sig0000006f),
    .I1(sig00000071),
    .S(sig00000015),
    .O(sig00000018)
  );
  MUXF7   blk0000002b (
    .I0(sig00000070),
    .I1(sig00000072),
    .S(sig00000015),
    .O(sig00000017)
  );
  XORCY   blk0000002c (
    .CI(sig0000007a),
    .LI(sig00000033),
    .O(sig00000024)
  );
  MUXCY   blk0000002d (
    .CI(sig0000007a),
    .DI(sig00000001),
    .S(sig00000033),
    .O(sig00000012)
  );
  XORCY   blk0000002e (
    .CI(sig0000007b),
    .LI(sig00000032),
    .O(sig00000023)
  );
  MUXCY   blk0000002f (
    .CI(sig0000007b),
    .DI(sig00000001),
    .S(sig00000032),
    .O(sig0000007a)
  );
  XORCY   blk00000030 (
    .CI(sig0000007c),
    .LI(sig00000031),
    .O(sig00000022)
  );
  MUXCY   blk00000031 (
    .CI(sig0000007c),
    .DI(sig00000001),
    .S(sig00000031),
    .O(sig0000007b)
  );
  XORCY   blk00000032 (
    .CI(sig0000007d),
    .LI(sig00000030),
    .O(sig00000021)
  );
  MUXCY   blk00000033 (
    .CI(sig0000007d),
    .DI(sig00000001),
    .S(sig00000030),
    .O(sig0000007c)
  );
  XORCY   blk00000034 (
    .CI(sig0000007e),
    .LI(sig00000001),
    .O(sig00000020)
  );
  MUXCY   blk00000035 (
    .CI(sig0000007e),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000007d)
  );
  XORCY   blk00000036 (
    .CI(sig0000007f),
    .LI(sig00000001),
    .O(sig0000001f)
  );
  MUXCY   blk00000037 (
    .CI(sig0000007f),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000007e)
  );
  XORCY   blk00000038 (
    .CI(sig00000080),
    .LI(sig00000001),
    .O(sig0000001e)
  );
  MUXCY   blk00000039 (
    .CI(sig00000080),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000007f)
  );
  XORCY   blk0000003a (
    .CI(sig00000081),
    .LI(sig00000001),
    .O(sig0000001d)
  );
  MUXCY   blk0000003b (
    .CI(sig00000081),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000080)
  );
  XORCY   blk0000003c (
    .CI(sig00000082),
    .LI(sig00000001),
    .O(sig0000001c)
  );
  MUXCY   blk0000003d (
    .CI(sig00000082),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000081)
  );
  XORCY   blk0000003e (
    .CI(sig00000083),
    .LI(sig00000001),
    .O(sig0000001b)
  );
  MUXCY   blk0000003f (
    .CI(sig00000083),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000082)
  );
  XORCY   blk00000040 (
    .CI(sig00000084),
    .LI(sig00000001),
    .O(sig0000001a)
  );
  MUXCY   blk00000041 (
    .CI(sig00000084),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000083)
  );
  XORCY   blk00000042 (
    .CI(sig00000011),
    .LI(sig00000001),
    .O(sig00000019)
  );
  MUXCY   blk00000043 (
    .CI(sig00000011),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000084)
  );
  XORCY   blk00000044 (
    .CI(sig00000085),
    .LI(NlwRenamedSig_OI_operation_rfd),
    .O(sig00000013)
  );
  XORCY   blk00000045 (
    .CI(sig00000086),
    .LI(sig0000003e),
    .O(sig0000002f)
  );
  MUXCY   blk00000046 (
    .CI(sig00000086),
    .DI(sig00000001),
    .S(sig0000003e),
    .O(sig00000085)
  );
  XORCY   blk00000047 (
    .CI(sig00000087),
    .LI(sig0000003d),
    .O(sig0000002e)
  );
  MUXCY   blk00000048 (
    .CI(sig00000087),
    .DI(sig00000001),
    .S(sig0000003d),
    .O(sig00000086)
  );
  XORCY   blk00000049 (
    .CI(sig00000088),
    .LI(sig0000003c),
    .O(sig0000002d)
  );
  MUXCY   blk0000004a (
    .CI(sig00000088),
    .DI(sig00000001),
    .S(sig0000003c),
    .O(sig00000087)
  );
  XORCY   blk0000004b (
    .CI(sig00000089),
    .LI(sig0000003b),
    .O(sig0000002c)
  );
  MUXCY   blk0000004c (
    .CI(sig00000089),
    .DI(sig00000001),
    .S(sig0000003b),
    .O(sig00000088)
  );
  XORCY   blk0000004d (
    .CI(sig0000008a),
    .LI(sig0000003a),
    .O(sig0000002b)
  );
  MUXCY   blk0000004e (
    .CI(sig0000008a),
    .DI(sig00000001),
    .S(sig0000003a),
    .O(sig00000089)
  );
  XORCY   blk0000004f (
    .CI(sig0000008b),
    .LI(sig00000039),
    .O(sig0000002a)
  );
  MUXCY   blk00000050 (
    .CI(sig0000008b),
    .DI(sig00000001),
    .S(sig00000039),
    .O(sig0000008a)
  );
  XORCY   blk00000051 (
    .CI(sig0000008c),
    .LI(sig00000038),
    .O(sig00000029)
  );
  MUXCY   blk00000052 (
    .CI(sig0000008c),
    .DI(sig00000001),
    .S(sig00000038),
    .O(sig0000008b)
  );
  XORCY   blk00000053 (
    .CI(sig0000008d),
    .LI(sig00000037),
    .O(sig00000028)
  );
  MUXCY   blk00000054 (
    .CI(sig0000008d),
    .DI(sig00000001),
    .S(sig00000037),
    .O(sig0000008c)
  );
  XORCY   blk00000055 (
    .CI(sig0000008e),
    .LI(sig00000036),
    .O(sig00000027)
  );
  MUXCY   blk00000056 (
    .CI(sig0000008e),
    .DI(sig00000001),
    .S(sig00000036),
    .O(sig0000008d)
  );
  XORCY   blk00000057 (
    .CI(sig0000008f),
    .LI(sig00000035),
    .O(sig00000026)
  );
  MUXCY   blk00000058 (
    .CI(sig0000008f),
    .DI(sig00000001),
    .S(sig00000035),
    .O(sig0000008e)
  );
  XORCY   blk00000059 (
    .CI(sig00000012),
    .LI(sig00000034),
    .O(sig00000025)
  );
  MUXCY   blk0000005a (
    .CI(sig00000012),
    .DI(sig00000001),
    .S(sig00000034),
    .O(sig0000008f)
  );
  LUT6 #(
    .INIT ( 64'h01EF01AB01450101 ))
  blk0000005b (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000014),
    .I3(sig00000015),
    .I4(sig00000006),
    .I5(sig0000000c),
    .O(sig00000038)
  );
  LUT6 #(
    .INIT ( 64'h5515511144044000 ))
  blk0000005c (
    .I0(sig00000015),
    .I1(sig00000018),
    .I2(sig00000017),
    .I3(sig00000008),
    .I4(sig00000006),
    .I5(sig0000000c),
    .O(sig00000037)
  );
  LUT6 #(
    .INIT ( 64'h5545544411011000 ))
  blk0000005d (
    .I0(sig00000015),
    .I1(sig00000018),
    .I2(sig00000017),
    .I3(sig00000008),
    .I4(sig00000006),
    .I5(sig0000000b),
    .O(sig00000036)
  );
  LUT5 #(
    .INIT ( 32'hEFEA4540 ))
  blk0000005e (
    .I0(sig00000016),
    .I1(sig00000044),
    .I2(sig00000017),
    .I3(sig00000046),
    .I4(sig0000000a),
    .O(sig0000000c)
  );
  LUT5 #(
    .INIT ( 32'h7F5D2A08 ))
  blk0000005f (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000014),
    .I3(sig00000009),
    .I4(sig00000002),
    .O(sig0000003b)
  );
  LUT5 #(
    .INIT ( 32'hEFEA4540 ))
  blk00000060 (
    .I0(sig00000018),
    .I1(sig00000009),
    .I2(sig00000017),
    .I3(sig0000000d),
    .I4(sig00000002),
    .O(sig0000003c)
  );
  LUT5 #(
    .INIT ( 32'hF7D5A280 ))
  blk00000061 (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000009),
    .I3(sig0000000d),
    .I4(sig00000007),
    .O(sig0000003d)
  );
  LUT5 #(
    .INIT ( 32'h73625140 ))
  blk00000062 (
    .I0(sig00000016),
    .I1(sig00000017),
    .I2(sig00000042),
    .I3(sig00000044),
    .I4(sig00000040),
    .O(sig0000000b)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000063 (
    .I0(sig00000015),
    .I1(sig00000018),
    .I2(sig0000000b),
    .I3(sig00000004),
    .O(sig00000035)
  );
  LUT5 #(
    .INIT ( 32'hEFEA4540 ))
  blk00000064 (
    .I0(sig00000015),
    .I1(sig00000047),
    .I2(sig00000016),
    .I3(sig0000004b),
    .I4(sig00000008),
    .O(sig0000000d)
  );
  LUT5 #(
    .INIT ( 32'h73625140 ))
  blk00000065 (
    .I0(sig00000015),
    .I1(sig00000016),
    .I2(sig00000045),
    .I3(sig00000049),
    .I4(sig00000041),
    .O(sig00000009)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000066 (
    .I0(sig00000017),
    .I1(sig00000048),
    .I2(sig00000046),
    .O(sig00000003)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000067 (
    .I0(sig00000017),
    .I1(sig00000041),
    .I2(sig0000003f),
    .O(sig00000005)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000068 (
    .I0(sig00000017),
    .I1(sig00000042),
    .I2(sig00000040),
    .O(sig0000000a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000069 (
    .I0(a[0]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig0000004f)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006a (
    .I0(a[10]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000059)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006b (
    .I0(a[11]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig0000005a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006c (
    .I0(a[12]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig0000005b)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006d (
    .I0(a[13]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig0000005c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006e (
    .I0(a[14]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig0000005d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006f (
    .I0(a[1]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000050)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000070 (
    .I0(a[2]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000051)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000071 (
    .I0(a[3]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000052)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000072 (
    .I0(a[4]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000053)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000073 (
    .I0(a[5]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000054)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000074 (
    .I0(a[6]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000055)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000075 (
    .I0(a[7]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000056)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000076 (
    .I0(a[8]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000057)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000077 (
    .I0(a[9]),
    .I1(\NlwRenamedSignal_result[31] ),
    .O(sig00000058)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000078 (
    .I0(sig00000015),
    .I1(sig00000073),
    .I2(sig00000075),
    .O(sig00000016)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000079 (
    .I0(sig00000015),
    .I1(sig00000073),
    .O(sig0000006d)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000007a (
    .I0(sig00000074),
    .I1(sig00000075),
    .O(sig0000006e)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000007b (
    .I0(sig0000004e),
    .I1(sig0000004d),
    .I2(sig0000004c),
    .I3(sig0000004b),
    .O(sig00000076)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000007c (
    .I0(sig0000004a),
    .I1(sig00000049),
    .I2(sig00000048),
    .I3(sig00000047),
    .O(sig00000077)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000007d (
    .I0(sig00000044),
    .I1(sig00000043),
    .I2(sig00000046),
    .I3(sig00000045),
    .O(sig00000078)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000007e (
    .I0(sig00000042),
    .I1(sig00000041),
    .I2(sig00000040),
    .I3(sig0000003f),
    .O(sig00000079)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000007f (
    .I0(sig00000017),
    .I1(sig00000044),
    .I2(sig00000042),
    .O(sig00000090)
  );
  LUT6 #(
    .INIT ( 64'h0E5E0E0E04540404 ))
  blk00000080 (
    .I0(sig00000016),
    .I1(sig00000003),
    .I2(sig00000015),
    .I3(sig00000017),
    .I4(sig00000040),
    .I5(sig00000090),
    .O(sig00000091)
  );
  LUT6 #(
    .INIT ( 64'h5757DF5702028A02 ))
  blk00000081 (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000014),
    .I3(sig00000006),
    .I4(sig00000015),
    .I5(sig00000091),
    .O(sig00000039)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000082 (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig00000048),
    .I3(sig00000044),
    .I4(sig00000046),
    .I5(sig0000004a),
    .O(sig00000092)
  );
  LUT6 #(
    .INIT ( 64'h5515511144044000 ))
  blk00000083 (
    .I0(sig00000015),
    .I1(sig00000016),
    .I2(sig00000017),
    .I3(sig00000042),
    .I4(sig00000044),
    .I5(sig00000003),
    .O(sig00000093)
  );
  LUT6 #(
    .INIT ( 64'hA8FDFDFDA8A8FDA8 ))
  blk00000084 (
    .I0(sig00000018),
    .I1(sig00000093),
    .I2(sig00000094),
    .I3(sig00000017),
    .I4(sig00000014),
    .I5(sig00000009),
    .O(sig0000003a)
  );
  LUT5 #(
    .INIT ( 32'hEFAB4501 ))
  blk00000085 (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000095),
    .I3(sig0000000d),
    .I4(sig00000007),
    .O(sig0000003e)
  );
  LUT3 #(
    .INIT ( 8'h27 ))
  blk00000086 (
    .I0(sig00000017),
    .I1(sig0000004a),
    .I2(sig0000004c),
    .O(sig00000096)
  );
  LUT4 #(
    .INIT ( 16'hFF45 ))
  blk00000087 (
    .I0(sig00000041),
    .I1(sig00000040),
    .I2(sig0000003f),
    .I3(sig00000042),
    .O(sig00000097)
  );
  LUT6 #(
    .INIT ( 64'h11110100BBBBABAA ))
  blk00000088 (
    .I0(sig00000075),
    .I1(sig00000046),
    .I2(sig00000044),
    .I3(sig00000043),
    .I4(sig00000045),
    .I5(sig00000097),
    .O(sig00000071)
  );
  LUT4 #(
    .INIT ( 16'hFF45 ))
  blk00000089 (
    .I0(sig00000049),
    .I1(sig00000048),
    .I2(sig00000047),
    .I3(sig0000004a),
    .O(sig00000098)
  );
  LUT6 #(
    .INIT ( 64'h11110100BBBBABAA ))
  blk0000008a (
    .I0(sig00000073),
    .I1(sig0000004e),
    .I2(sig0000004c),
    .I3(sig0000004b),
    .I4(sig0000004d),
    .I5(sig00000098),
    .O(sig0000006f)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk0000008b (
    .I0(sig00000042),
    .I1(sig00000040),
    .I2(sig0000003f),
    .I3(sig00000041),
    .O(sig00000099)
  );
  LUT6 #(
    .INIT ( 64'h01010100ABABABAA ))
  blk0000008c (
    .I0(sig00000075),
    .I1(sig00000045),
    .I2(sig00000046),
    .I3(sig00000043),
    .I4(sig00000044),
    .I5(sig00000099),
    .O(sig00000072)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk0000008d (
    .I0(sig0000004a),
    .I1(sig00000048),
    .I2(sig00000047),
    .I3(sig00000049),
    .O(sig0000009a)
  );
  LUT6 #(
    .INIT ( 64'h01010100ABABABAA ))
  blk0000008e (
    .I0(sig00000073),
    .I1(sig0000004d),
    .I2(sig0000004e),
    .I3(sig0000004b),
    .I4(sig0000004c),
    .I5(sig0000009a),
    .O(sig00000070)
  );
  LUT6 #(
    .INIT ( 64'h0101010000010000 ))
  blk0000008f (
    .I0(sig00000017),
    .I1(sig00000015),
    .I2(sig00000073),
    .I3(sig00000018),
    .I4(sig00000040),
    .I5(sig0000003f),
    .O(sig00000031)
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  blk00000090 (
    .I0(sig0000003f),
    .I1(sig00000018),
    .I2(sig00000017),
    .I3(sig00000015),
    .I4(sig00000073),
    .O(sig00000030)
  );
  LUT5 #(
    .INIT ( 32'h15110400 ))
  blk00000091 (
    .I0(sig00000015),
    .I1(sig00000018),
    .I2(sig00000073),
    .I3(sig0000000a),
    .I4(sig00000004),
    .O(sig00000034)
  );
  LUT5 #(
    .INIT ( 32'h11100100 ))
  blk00000092 (
    .I0(sig00000015),
    .I1(sig00000073),
    .I2(sig00000018),
    .I3(sig0000000a),
    .I4(sig00000005),
    .O(sig00000033)
  );
  LUT6 #(
    .INIT ( 64'h0101110100001000 ))
  blk00000093 (
    .I0(sig00000015),
    .I1(sig00000073),
    .I2(sig00000018),
    .I3(sig00000040),
    .I4(sig00000017),
    .I5(sig00000005),
    .O(sig00000032)
  );
  LUT4 #(
    .INIT ( 16'h1000 ))
  blk00000094 (
    .I0(sig00000017),
    .I1(sig00000075),
    .I2(sig00000015),
    .I3(sig00000040),
    .O(sig00000094)
  );
  LUT5 #(
    .INIT ( 32'h0415AEBF ))
  blk00000095 (
    .I0(sig00000015),
    .I1(sig00000073),
    .I2(sig00000049),
    .I3(sig0000004d),
    .I4(sig00000006),
    .O(sig00000095)
  );
  LUT5 #(
    .INIT ( 32'hEFAB4501 ))
  blk00000096 (
    .I0(sig00000015),
    .I1(sig00000073),
    .I2(sig00000096),
    .I3(sig00000003),
    .I4(sig0000000b),
    .O(sig00000007)
  );
  LUT6 #(
    .INIT ( 64'h8A8A8ADFDF8ADFDF ))
  blk00000097 (
    .I0(sig00000015),
    .I1(sig00000075),
    .I2(sig0000003f),
    .I3(sig00000073),
    .I4(sig00000047),
    .I5(sig00000043),
    .O(sig00000014)
  );
  LUT5 #(
    .INIT ( 32'h73625140 ))
  blk00000098 (
    .I0(sig00000016),
    .I1(sig00000017),
    .I2(sig00000041),
    .I3(sig00000043),
    .I4(sig0000003f),
    .O(sig00000004)
  );
  LUT3 #(
    .INIT ( 8'h15 ))
  blk00000099 (
    .I0(sig0000000e),
    .I1(sig00000074),
    .I2(sig00000015),
    .O(result[28])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk0000009a (
    .I0(sig0000000e),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[30])
  );
  LUT5 #(
    .INIT ( 32'hF2D0F780 ))
  blk0000009b (
    .I0(sig00000015),
    .I1(sig00000075),
    .I2(sig00000041),
    .I3(sig00000045),
    .I4(sig00000073),
    .O(sig00000006)
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk0000009c (
    .I0(sig0000002e),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[21])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk0000009d (
    .I0(sig0000002f),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[22])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk0000009e (
    .I0(sig0000002b),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[18])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk0000009f (
    .I0(sig0000002d),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[20])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a0 (
    .I0(sig0000002c),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[19])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a1 (
    .I0(sig00000028),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[15])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a2 (
    .I0(sig0000002a),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[17])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a3 (
    .I0(sig00000029),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[16])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a4 (
    .I0(sig00000025),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[12])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a5 (
    .I0(sig00000027),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[14])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a6 (
    .I0(sig00000026),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[13])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a7 (
    .I0(sig00000022),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[9])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a8 (
    .I0(sig00000024),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[11])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000a9 (
    .I0(sig00000023),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[10])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000aa (
    .I0(sig0000001f),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[6])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000ab (
    .I0(sig00000021),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[8])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000ac (
    .I0(sig00000020),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[7])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000ad (
    .I0(sig0000001c),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[3])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000ae (
    .I0(sig0000001e),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[5])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000af (
    .I0(sig0000001d),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[4])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000b0 (
    .I0(sig0000001b),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[2])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000b1 (
    .I0(sig0000001a),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[1])
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  blk000000b2 (
    .I0(sig00000019),
    .I1(sig00000015),
    .I2(sig00000074),
    .O(result[0])
  );
  LUT5 #(
    .INIT ( 32'hF2D0F780 ))
  blk000000b3 (
    .I0(sig00000015),
    .I1(sig00000075),
    .I2(sig0000003f),
    .I3(sig00000043),
    .I4(sig00000073),
    .O(sig00000008)
  );
  LUT6 #(
    .INIT ( 64'h7757755522022000 ))
  blk000000b4 (
    .I0(sig00000015),
    .I1(sig00000075),
    .I2(sig00000017),
    .I3(sig00000040),
    .I4(sig00000042),
    .I5(sig00000092),
    .O(sig00000002)
  );
  LUT6 #(
    .INIT ( 64'h7007070707070707 ))
  blk000000b5 (
    .I0(sig00000015),
    .I1(sig00000074),
    .I2(sig00000016),
    .I3(sig00000018),
    .I4(sig00000013),
    .I5(sig00000017),
    .O(result[25])
  );
  LUT5 #(
    .INIT ( 32'h70070707 ))
  blk000000b6 (
    .I0(sig00000015),
    .I1(sig00000074),
    .I2(sig00000017),
    .I3(sig00000018),
    .I4(sig00000013),
    .O(result[24])
  );
  LUT6 #(
    .INIT ( 64'h4000000000000000 ))
  blk000000b7 (
    .I0(sig00000074),
    .I1(sig00000015),
    .I2(sig00000018),
    .I3(sig00000017),
    .I4(sig00000075),
    .I5(sig00000013),
    .O(\NlwRenamedSignal_result[27] )
  );
  LUT6 #(
    .INIT ( 64'h7F7F7FFFFFFFFFFF ))
  blk000000b8 (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000015),
    .I3(sig00000074),
    .I4(sig00000013),
    .I5(sig00000075),
    .O(sig0000000e)
  );
  LUT4 #(
    .INIT ( 16'h7007 ))
  blk000000b9 (
    .I0(sig00000015),
    .I1(sig00000074),
    .I2(sig00000018),
    .I3(sig00000013),
    .O(result[23])
  );
  LUT6 #(
    .INIT ( 64'h1555555595555555 ))
  blk000000ba (
    .I0(sig00000015),
    .I1(sig00000018),
    .I2(sig00000013),
    .I3(sig00000017),
    .I4(sig00000016),
    .I5(sig00000074),
    .O(result[26])
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
