<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF DocConverter 2014
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oDC = new COM("APDocConverter.Object");

$results = $oDC->ConvertToPDF($strPath . "word.doc", $strPath . "word.pdf");
if ($results->DocConverterStatus != 0) {
  Error("ConvertToPDF", $results, $results->DocConverterStatus);
}

$results = $oDC->ConvertFromPDF($strPath . "word.pdf", $strPath . "word.pdf", 1);
if ($results->DocConverterStatus != 0) {
  Error("ConvertFromPDF", $results, $results->DocConverterStatus);
}

// Release Object
$oDC = null;

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