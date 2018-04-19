<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF CADConverter 2015
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oDC = new COM("APDocConverter.Object");

// Settings specific to CAD conversions
$oCAD = new COM("CADConverter.Object");

// Options available for CAD conversions
$oCAD->ASCIIHexEncoding = false;
$oCAD->Color = 0;
$oCAD->EmbedFonts = 2;
$oCAD->ExportLayers = 2;
$oCAD->ExportLayouts = 0;
$oCAD->FlateCompression = false;
$oCAD->HatchToBitmapDPI = 150;
$oCAD->HiddenLineRemoval = false;
$oCAD->Lineweight = -1;
$oCAD->OtherHatchesSettings = 0;
$oCAD->PlotStyleTableName = "";
$oCAD->SHXTextAsGeometry = false;
$oCAD->SimpleGeometryOptimization = false;
$oCAD->SolidHatchesSettings = 2;
$oCAD->TrueTypeAsGeometry = false;
$oCAD->ZoomToExtents = true;

// Page size is only set if ZoomToExtents is true
$oCAD->SetExtentsPageSize(210, 297);

// Convert the settings to XML and send it to DocConverter
$cadXML = $oCAD->Serialize();
$oDC->SetAddonOptions($cadXML);

// Release Object
$oCAD = null;

// Convert the file to PDF
$results = $oDC->ConvertToPDF($strPath . "sample.dwg", $strPath . "new.pdf");
if ($results->DocConverterStatus != 0) {
  Error("ConvertToPDF", $results, $results->DocConverterStatus);
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