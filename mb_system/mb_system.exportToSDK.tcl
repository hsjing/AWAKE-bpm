proc exportToSDK {} {
  cd C:/Users/student/Desktop/Jing/awake.bpm.firmware/mb_system
  if { [ catch { xload xmp mb_system.xmp } result ] } {
    exit 10
  }
  if { [run exporttosdk] != 0 } {
    return -1
  }
  return 0
}

if { [catch {exportToSDK} result] } {
  exit -1
}

set sExportDir [ xget sdk_export_dir ]
set sExportDir [ file join "C:/Users/student/Desktop/Jing/awake.bpm.firmware/mb_system" "$sExportDir" "hw" ] 
if { [ file exists C:/Users/student/Desktop/Jing/awake.bpm.firmware/edkBmmFile_bd.bmm ] } {
   puts "Copying placed bmm file C:/Users/student/Desktop/Jing/awake.bpm.firmware/edkBmmFile_bd.bmm to $sExportDir" 
   file copy -force "C:/Users/student/Desktop/Jing/awake.bpm.firmware/edkBmmFile_bd.bmm" $sExportDir
}
if { [ file exists C:/Users/student/Desktop/Jing/awake.bpm.firmware/mbx2_system_top.bit ] } {
   puts "Copying bit file C:/Users/student/Desktop/Jing/awake.bpm.firmware/mbx2_system_top.bit to $sExportDir" 
   file copy -force "C:/Users/student/Desktop/Jing/awake.bpm.firmware/mbx2_system_top.bit" $sExportDir
}
exit $result
