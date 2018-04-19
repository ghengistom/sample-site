<?php
$outputPath = "../../example-backups/files";
 
/* PUT data comes in on the stdin stream */
$putdata = fopen("php://input", "r");
 
$date = date('Ymd');
 
/* Open a file for writing */
$fp = fopen("$outputPath/$date.files.gz", "wb");
 
/* Read the data 1 KB at a time
   and write to the file */
while ($data = fread($putdata, 1024)) {
  fwrite($fp, $data);
}
 
/* Close the streams */
fclose($fp);
fclose($putdata);
 
// Remove old backups, unless it was the first of the month
$tooOld = strtotime('-1 month');
 
if ($handle = opendir($outputPath)) {
  clearstatcache();
  while (false !== ($file = readdir($handle))) {
    if ($file != "." && $file != ".." && filemtime("$outputPath/".$file) < $tooOld && date('j', filemtime("$outputPath/".$file)) != 1) {
      // if file is older than tooOld and it's not the 1st of the month backup. delete it.
      @unlink("$outputPath/".$file);
    }
  }
  closedir($handle);
}
 
?>