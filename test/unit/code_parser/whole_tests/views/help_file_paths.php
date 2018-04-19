<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

$intImageToPDF = ->ImageToPDF($strPath . "IMG.jpg", $strPath . "IMG.pdf");
if ($intImageToPDF != 1) {
  Error("ImageToPDF", $intImageToPDF);
}
// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>