proc pnsynth {} {
  cd C:/Users/student/Desktop/Jing/awake.bpm.firmware/mb_system
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
