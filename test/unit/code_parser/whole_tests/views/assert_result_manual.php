<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Xtractor 2015
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

$results = $oXT->OpenPDF($strPath . "PDF.pdf");
if (results.XtractorStatus != XDK.Results.XtractorStatus.Success) {
  Error("OpenPDF", results, results->XtractorStatus);
} else {
  $ExtractedText = $oXT->GetTextByLocation(2, 100, 400, 200);
}
$oXT->ClosePDF();

// Release Object
$oXT = null;

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