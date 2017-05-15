if { [ catch { xload xmp C:/Myprojects/CERN_AWAKE_BPM/FPGA_SPARTAN/AWAKE_BPM_Rev1_0/mb_system/mb_system.xmp } result ] } {
  exit 10
}
set gotbram [xget hasbram]
if { $gotbram == 1 } {
   #
   # Call the test bench generation
   if { [catch {run memgen -od C:/Myprojects/CERN_AWAKE_BPM/FPGA_SPARTAN/AWAKE_BPM_Rev1_0 C:/Myprojects/CERN_AWAKE_BPM/FPGA_SPARTAN/AWAKE_BPM_Rev1_0/mb_system/mb_system.mhs} result ] } {
      puts "ERROR: xps 'run memgen' call failed"
      exit -1
   }
}
exit 0
