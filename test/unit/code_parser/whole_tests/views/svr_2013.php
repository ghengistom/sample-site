<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2013
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oSVR = new COM("APServer.Object");

$results = $oSVR->ConvertPSToPDF($strPath . "ps.ps", $strPath . "ps.pdf");
if ($results->ServerStatus != 0) {
  Error("ConvertPSToPDF", $results, $results->ServerStatus);
}

// Release Object
$oSVR = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $oResults, $errorStatus) {
  echo "Error with " . $method . ": <br/>"
    . $errorStatus . "<br/>"
    . $oResults->details;
  exit(1);
}
?>