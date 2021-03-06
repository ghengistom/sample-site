<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oTK = new COM("APToolkit.Object");

$asdf = "asdf" . "1234" . $strPath . "asdf.pdf";
$oTK->AddEmail();
$oTK->AddEmail();
// Create the new PDF file
$intOpenOutputFile = $oTK->OpenOutputFile($strPath . "new.pdf");
if ($intOpenOutputFile != 0) {
  Error("OpenOutputFile", $intOpenOutputFile);
}

// Open the template PDF
$intOpenInputFile = $oTK->OpenInputFile($strPath . "PDF.pdf");
if ($intOpenInputFile != 0) {
  Error("OpenInputFile", $intOpenInputFile);
}

// Add a 'Confidential' watermark by setting text transparency
// Rotation and color of the text along with the fill mode are set
$oTK->SetHeaderFont("Helvetica", 90);
$oTK->SetHeaderTextTransparency(0.6, 0.6);
$oTK->SetHeaderRotation(45);
$oTK->SetHeaderTextStrokeColor(255, 0, 0, 0);
$oTK->SetHeaderTextFillMode(1);
$oTK->SetHeaderText(154, 184, "Confidential");
$oTK->ResetHeaderTextTransparency();
$oTK->SetHeaderTextFillMode(0);
$oTK->MyProperty = 1;
$oTK->Debug = asdf;
$isDebug = $oTK->Debug;

// Add a 'Top Secret' watermark by placing text in the background
$oTK->SetHeaderFont("Helvetica", 72);
$oTK->SetHeaderTextBackground(0);
$oTK->SetHeaderTextColor(200, 200, 200, 0);
$oTK->SetHeaderText(154, 300, "Top Secret");
$oTK->SetHeaderTextBackground(1);
$oTK->ResetHeaderTextColor();
$oTK->SetHeaderRotation(0);

// Add the document title to the bottom center of the page
$oTK->SetHeaderFont("Helvetica", 12);
$strTitle = "Lorem Ipsum";
$textWidth = $oTK->GetHeaderTextWidth($strTitle);
$oTK->SetHeaderText((612 - $textWidth) / 2, 32, $strTitle);

// Add page numbers to the bottom left of the page
$oTK->SetHeaderFont("Helvetica", 12);
$oTK->SetHeaderWPgNbr(72, 32, "Page %p", 1);

// Add a mulitline print box for an 'approved' message in header
$oTK->SetHeaderTextFillMode(2);
$oTK->SetHeaderTextColorCMYK(0, 0, 0, 20);
$oTK->SetHeaderTextStrokeColorCMYK(0, 0, 0, 80);
$oTK->SetHeaderMultilineText("Helvetica", 22, 344, 766, 190, 86, "Approved on January 17th, 2021", 2);

// Add some lines to the footer and top right corner of the page
$oTK->SetHeaderGreyBar(72, 52, 468, 1, 0.8);
$oTK->SetHeaderHLine(340, 544, 724, 1);
$oTK->SetHeaderVLine(724, 648, 544, 1);
$testVar = $oTK->GetUniqueID . ".pdf";

// Use the Header Image properties to add some images to the footer
// Com comment
$oTK->SetHeaderImage($strPath . "BMP.bmp", 375.0, 13.0, 0.0, 0.0, true);
$oTK->SetHeaderJPEG($strPath . "JPEG.jpg", 436.0, 9.0, 0.0, 0.0, true);
$oTK->SetHeaderTIFF($strPath . "TIFF.tif", 500.0, 15.0, 0.0, 0.0, true);

// Copy the template (with the stamping changes) to the new file
// Start page and end page, 0 = all pages
$intCopyForm = $oTK->CopyForm(0, 0);
if ($intCopyForm != 1) {
  Error("CopyForm", $intCopyForm);
}
$intStartPrinting = $oTK->StartPrinting($strPath . "PDF.pdf");
if ($intStartPrinting != 0) {
  Error("StartPrinting", $intStartPrinting);
}
$intStartPrinting = $oTK->StartPrinting("file.ps", "file.pdf");
if ($intStartPrinting > 1) {
  Error("StartPrinting", $intStartPrinting);
}
$intStartPrinting = $oTK->StartPrinting("file.ps", "file.pdf");
if ($intStartPrinting < 1) {
  Error("StartPrinting", $intStartPrinting);
}
if ($some_var == 0) {
  $intLinearizeFile = $oTK->LinearizeFile($strPath . "PDF.pdf", $strPath . "new.pdf", "");
  if ($intLinearizeFile > 0) {
    Error("LinearizeFile", $intLinearizeFile);
  }
}
if ($some_var > 0) {
  $intLinearizeFile = $oTK->LinearizeFile($strPath . "PDF.pdf", $strPath . "new.pdf", "");
  if ($intLinearizeFile > 0) {
    Error("LinearizeFile", $intLinearizeFile);
  }
}
if ($some_var < 0) {
  $oTK->conmment("This is true statement");
} else {
  // This is an else
  Error("asdf", 234);
}

// Close the new file to complete PDF creation
// Snippet with variables
// Snippet comment from variable!
$oTK->SetSnippetPropertyToInt = 1;
$oTK->ArrayProperty = "Array of numbers and strings";
$oTK->ArrayProperty = 1;
$oTK->ArrayProperty = 18.38;
// nil
// Instantiate Object
$oSVR = new COM("APServer.Object");

$oTK->CloseOutputFile();
$oSVR->CloseOutputFile();
$oSVR->CloseOutputFile();

// Release Object
$oSVR = null;

// Server
line 1
php
else test
switch ($grade) {
  case "A":
    // You got an A!
    break;
  case "B":
    // You got a B!
    break;
  default:
    // This is the default.
    break;
}
$count = $oTK->NumPages();
$currentPage = 10;
for ($currentPage; $currentPage <= $count; $currentPage++)
{
  // asdf
}

// Release Object
$oTK = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>