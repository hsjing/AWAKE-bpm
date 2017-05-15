proc pnsynth {} {
  cd C:/Myprojects/CERN_AWAKE_BPM/FPGA_SPARTAN/AWAKE_BPM_Rev2_0/mb_system
  if { [ catch { xload xmp mb_system.xmp } result ] } {
    exit 10
  }
  if { [catch {run netlist} result] } {
    return -1
  }
  return $result
}
if { [catch {pnsynth} result] } {
  exit -1
}
exit $result
