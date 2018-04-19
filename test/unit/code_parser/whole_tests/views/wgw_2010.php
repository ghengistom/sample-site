<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF WebGrabber WBE 2010
// Example generated 01/01/2000 
?>

<?php
// Instantiate Object
$oWG = new COM("APWebGrabber.Object");

// Perform the HTML to PDF conversion
$intDoPrint = $oWG->DoPrint("127.0.0.1", 58585);
if ($intDoPrint != 0) {
  Error("DoPrint", $intDoPrint);
}

// Cleans up all internal string variables used during conversion
// By default variables are deleted 3 minutes after the conversion
$oWG->CleanUp("127.0.0.1", 58585);

// Release Object
$oWG = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>