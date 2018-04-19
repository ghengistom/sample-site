<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$objVAR = new COM("APProduct.Object");


// Release Object
$objVAR = null;

// Instantiate Object
$oDC = new COM("APDocConv.Object");


// Release Object
$oDC = null;

// Instantiate Object
$oDCw = new COM("DocConverterWBE.Object");


// Release Object
$oDCw = null;

// Instantiate Object
$oMER = new COM("APMeridian.Object");


// Release Object
$oMER = null;

// Instantiate Object
$oSVR = new COM("APServer.Object");


// Release Object
$oSVR = null;

// Instantiate Object
$oTK = new COM("APToolkit.Object");


// Release Object
$oTK = null;

// Instantiate Object
$oWG = new COM("APWebGrabber.Object");


// Release Object
$oWG = null;


// Release Object
$oXT = null;

->with_();
->with_toolkit();
// Instantiate Object
$oWG = new COM("APWebGrabber.Object");

$intDoPrint = $oWG->DoPrint("127.0.0.1", 58585);
if ($intDoPrint != 0) {
  Error("DoPrint", $intDoPrint);
}
// Instantiate Object
$oTK = new COM("APToolkit.Object");

$intOpenInputFile = $oTK->OpenInputFile($strPath . "new.pdf");
if ($intOpenInputFile != 0) {
  Error("OpenInputFile", $intOpenInputFile);
}
$oWG->Function("asdf");

// Release Object
$oTK = null;


// Release Object
$oWG = null;

// Instantiate Object
$oDC = new COM("APDocConv.Object");

$fPDF = new COM("APDocConverter.FromPDFOptions");
$fPDF->ToWordHeadersAndFootersMode = 0;
$oDC->SetFromPDFOptions(fPDF);

// Release Object
$fPDF = null;

// Release Object
$oDC = null;

$fPDF = new COM("APDocConverter.FromPDFOptions");
$fPDF->ToWordHeadersAndFootersMode = 0;

// Release Object
$fPDF = null;
// Instantiate Object
$oDC = new COM("APDocConv.Object");

// Snippet with variables
$oDC->SetSnippetPropertyToInt = 1;
$oDC->ArrayProperty = "Array of numbers and strings";
$oDC->ArrayProperty = 1;
$oDC->ArrayProperty = 18.38;
// nil

// Release Object
$oDC = null;

$fPDF = new COM("APDocConverter.FromPDFOptions");
$fPDF->ToWordHeadersAndFootersMode = 0;
$oDC->SetFromPDFOptions($fPDF);

// Release Object
$fPDF = null;
$oXMP = ->GetXmpManager();
$oXMP->AddFieldsToXMP = 1;
$oXMPField = $oXMP->GetXMPFieldInfo("name");
$strFieldInfo = $oXMPField->Name;

// Release Object
$oXMPField = null;

// Release Object
$oXMP = null;
// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>