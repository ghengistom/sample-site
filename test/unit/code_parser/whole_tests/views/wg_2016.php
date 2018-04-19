<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF WebGrabber 2016
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oWG = new COM("APWebGrabber.Object");

// C:\ProgramData\activePDF\Logs\
$oWG->Debug = true;

$oWG->LinearizePDF = true;

// Set the amount of seconds before a request will time out
$oWG->Timeout = 40;

// Margins (Top, Bottom, Left, Right) 1.0 = 1"
$oWG->SetMargins(0.75, 0.75, 0.75, 0.75);

// 0 = Portrait, 1 = Landscape
$oWG->Orientation = 0;

// Rendering engine used for the HTML
// 0 = Native, 1 = IE
$oWG->EngineToUse = 1;

// Convert the HTML background (IE engine only)
$oWG->PrintBackground = true;

// PDF output location and filename
$oWG->OutputDirectory = $strPath;
$oWG->NewDocumentName = "basic.pdf";

// HTML to convert
// Examples:
// http://domain.com/path/file.aspx
// c:\folder\file.html
$oWG->URL = "http://examples.activepdf.com/samples/doc";

// Perform the HTML to PDF conversion
$results = $oWG->ConvertToPDF("127.0.0.1", 52525);
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