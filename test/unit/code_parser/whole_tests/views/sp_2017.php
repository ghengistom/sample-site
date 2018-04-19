<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Spooler 2017
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$objVAR = new COM("APProduct.Object");

// Use the PrinterInfo object to retrieve current settings
// and available options for the specified printer.
$oPI = $objVAR->PrinterInfo("Microsoft Print to PDF");

$arrayAvailableDPIs = $oPI->AvailableDPI;
$arrayBinSources = $oPI->BinSources;
$isCollate = $oPI->Collate;
$valColorMode = $oPI->ColorMode;
$valDPI = $oPI->DPI;
$valDuplex = $oPI->Duplex;
$arrayFormNames = $oPI->FormNames;
$valOrientation = $oPI->Orientation;
$arrayPaperSizes = $oPI->PaperSizes;
$valPrinterName = $oPI->PrinterName;
$valTrueType = $oPI->TrueTypeOption;

// Release Object
$oPI = null;

// Use the PrintJobProfile object to set specific printer settings
// for the print job if the default options are not what is needed.
$oPJP = $objVAR->PrintJobProfile("SettingsOne");

$oPJP->BinSource = 15;
$oPJP->Collate = false;
$oPJP->ColorMode = 2;
$oPJP->DPI = 300;
$oPJP->Duplex = 1;
$oPJP->FormName = "SampleForm";
$oPJP->Nup = 0;
$oPJP->Orientation = 1;
$oPJP->PaperSize = 1;
$oPJP->PrinterName = "Microsoft Print to PDF";
$oPJP->PrintOddEvenAll = 3;
$oPJP->ProfileName = "SettingsOne";
$oPJP->Scaling = 1;
$oPJP->CustomScaling = 95.0;
$oPJP->TrueTypeOption = 3;

// File specific settings
$objVAR->Copies = 1;
$objVAR->PageRange = "1-2,4";
$objVAR->PrintAnnotations = true;

// Print directly to a printer. Leave first parameter blank for default printer
$results = $objVAR->PrintFileCustom(oPJP, $strPath . "5pageLI.pdf", "");
if ($results->Status != 0) {
  Error("PrintFileCustom", $results, $results->Status);
}

// Release Object
$oPJP = null;

// Release Object
$objVAR = null;

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