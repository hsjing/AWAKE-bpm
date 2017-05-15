@echo off
REM  Simulation Model Generator
REM  Xilinx EDK 13.3 EDK_O.76xd
REM  Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
REM
REM  File     mb_system_fuse.cmd (Mon Mar 07 16:24:29 2016)
REM
REM  ISE Simulator Fuse Script File
REM
REM  The Fuse script compiles and generates an ISE simulator
REM  executable named isim_mb_system.exe that is used to run your
REM  simulation. To run a simulation in command line mode,
REM  perform the following steps:
REM
REM  1. Run the ISE Simulator Fuse script file
REM     CMD /K mb_system_fuse.cmd
REM  2. Use a text editor to modify the signal wave files,
REM     which have the file name <module>_wave.tcl
REM  3. Launch the simulator using the following command:
REM     isim_mb_system.exe -gui -tclbatch mb_system_setup.tcl
REM
fuse -incremental work.mb_system_tb work.glbl -prj mb_system.prj -L xilinxcorelib_ver -L secureip -L unisims_ver  -o isim_mb_system.exe
