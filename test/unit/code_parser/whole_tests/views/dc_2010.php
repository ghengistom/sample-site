<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF DocConverter Enterprise 2010
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oDC = new COM("APDocConv.Object");

$intSubmit = $oDC->Submit("127.0.0.1", 58585, $strPath . "word.doc", $strPath, $strPath, $strPath, "", "", false, "");
if ($intSubmit != 0) {
  Error("Submit", $intSubmit);
}

// Release Object
$oDC = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>