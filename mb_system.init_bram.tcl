cd C:/Users/student/Desktop/Jing/awake.bpm.firmware/mb_system
if { [ catch { xload xmp mb_system.xmp } result ] } {
  exit 10
}

if { [catch {run init_bram} result] } {
  exit -1
}

exit 0
