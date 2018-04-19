<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Meridian 2010
// Example generated 01/01/2000 
?>

<?php
// Instantiate Object
$oMER = new COM("APMeridian.Object");

$intWait = $oMER->Wait(30);
if ($intWait != 0) {
  Error("Wait", $intWait);
}

// Release Object
$oMER = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>