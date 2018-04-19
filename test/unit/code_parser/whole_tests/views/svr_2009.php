<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oSVR = new COM("APServer.Object");

$intPSToPDF = $oSVR->PSToPDF($strPath . "ps.ps", $strPath . "ps.pdf");
if ($intPSToPDF != 0) {
  Error("PSToPDF", $intPSToPDF);
}

// Release Object
$oSVR = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>