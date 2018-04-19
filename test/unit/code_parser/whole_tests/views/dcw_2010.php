<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF DocConverter WBE 2010
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oDCw = new COM("DocConverterWBE.Object");

$intConvertToPDF = $oDCw->ConvertToPDF($strPath . "word.doc", $strPath . "word.pdf");
if ($intConvertToPDF != 0) {
  Error("ConvertToPDF", $intConvertToPDF);
}

// Release Object
$oDCw = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>