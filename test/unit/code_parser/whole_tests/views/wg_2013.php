<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF WebGrabber 2016
// Example generated 01/01/2000 
?>

<?php
// Instantiate Object
$oWG = new COM("APWebGrabber.Object");

$results = $oWG->ConvertToPDF("127.0.0.1", 90);
if ($results->WebGrabberStatus != 0) {
  Error("ConvertToPDF", $results, $results->WebGrabberStatus);
}

// Release Object
$oWG = null;

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