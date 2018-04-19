<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

->MethodName("asdf", "#FF9900", 1, 2.0, true);
->AddEmail();
$intStartPrinting = ->StartPrinting("file.ps", "file.pdf");
if ($intStartPrinting != 0) {
  Error("StartPrinting", $intStartPrinting);
}
$intStartPrinting = ->StartPrinting("file.ps", "file.pdf");
if ($intStartPrinting < 1) {
  Error("StartPrinting", $intStartPrinting);
}
$intStartPrinting = ->StartPrinting("file.ps", "file.pdf");
if ($intStartPrinting > 1) {
  Error("StartPrinting", $intStartPrinting);
}
$results = ->StartPrinting("file.ps", "file.pdf");
if ($results->ServerStatus != 0) {
  Error("StartPrinting", $results, $results->ServerStatus);
}
$results = ->ClosePDF();
if ($results->ServerStatus != 0) {
  Error("ClosePDF", $results, $results->ServerStatus);
}
$intBeginStartPrinting = ->BeginStartPrinting($strPath . "file.ps", $strPath . "file.pdf");
if ($intBeginStartPrinting != 0) {
  Error("BeginStartPrinting", $intBeginStartPrinting);
}
$intBeginStartPrinting = ->BeginStartPrinting("file.ps", "file.pdf");
if ($intBeginStartPrinting < 1) {
  Error("BeginStartPrinting", $intBeginStartPrinting);
}
Error("MethodName", VariableName);
$ManualResults = ->OpenPDF($strPath . "Report.pdf");
if (results.XtractorStatus != XDK.Results.XtractorStatus.Success) {
  Error("OpenPDF", ManualResults, ManualResults->XtractorStatus);
} else {
  $ExtractedText = ->GetTextByLocation(2, 100, 400, 200);
}
$oXMP = ->GetXMPManager();
// Set a document property
$intSetDocumentProperty = $oXMP->SetDocumentProperty(2, "John Doe");
if ($intSetDocumentProperty != 0) {
  Error("SetDocumentProperty", $intSetDocumentProperty);
}
$intSetDocumentProperty = $oXMP->SetDocumentProperty(2, "John Doe");
if ($intSetDocumentProperty != 0) {
  Error("SetDocumentProperty", $intSetDocumentProperty);
}
$intSetDocumentProperty = $oXMP->SetDocumentProperty(2, 4);
if ($intSetDocumentProperty != 0) {
  Error("SetDocumentProperty", $intSetDocumentProperty);
}
$oXMP->RemoveDocumentProperty(2);

// Release Object
$oXMP = null;
$oReleaseOne = ->MethodObject();

// Release Object
$oReleaseOne = null;
$oReleaseTwo = ->MethodObject();

// Release Object
$oReleaseTwo = null;
$oNoRelease = ->MethodObject();

// Release Object
$oNoRelease = null;
// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>