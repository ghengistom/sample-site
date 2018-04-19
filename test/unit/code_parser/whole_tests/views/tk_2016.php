<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Toolkit 2016
// Example generated 01/01/2000 
?>

<?php
// Get current path
$strPath = dirname(__FILE__) . "\\";

// Instantiate Object
$oTK = new COM("APToolkit.Object");

// Create the new PDF file
$intOpenOutputFile = $oTK->OpenOutputFile($strPath . "new.pdf");
if ($intOpenOutputFile != 0) {
  Error("OpenOutputFile", $intOpenOutputFile);
}

// Open the template PDF
$intOpenInputFile = $oTK->OpenInputFile($strPath . "form.pdf");
if ($intOpenInputFile != 0) {
  Error("OpenInputFile", $intOpenInputFile);
}

// Get the reference to the XMP object
$oXMP = $oTK->GetXMPManager();

// Set a document property
$intSetDocumentProperty = $oXMP->SetDocumentProperty(2, "John Doe");
if ($intSetDocumentProperty != 0) {
  Error("SetDocumentProperty", $intSetDocumentProperty);
}

// Set a custom property
$intSetCustomProperty = $oXMP->SetCustomProperty("example", "http://examples.activepdf.com");
if ($intSetCustomProperty != 0) {
  Error("SetCustomProperty", $intSetCustomProperty);
}

// Set the namespace for the user property
$oXMP->SetNamespace("dc", "http://purl.org/dc/elements/1.1/");

// Set a user property
$intSetUserProperty = $oXMP->SetUserProperty("contributor", "ActivePDF");
if ($intSetUserProperty != 0) {
  Error("SetUserProperty", $intSetUserProperty);
}

// Remove a property
$oXMP->RemoveDocumentProperty(2);

// Release Object
$oXMP = null;

// Get the reference to the InitialViewInfo object
$oIVI = $oTK->GetInitialViewInfo();

// Options for viewer window
$oIVI->CenterWindow = true;
$oIVI->FullScreen = false;
$oIVI->ResizeWindow = true;
// 0 = Display the filename
// 1 = Display the document title
$oIVI->Show = 1;

// Show or hide UI elements of the viewer
$oIVI->HideMenuBar = true;
$oIVI->HideToolBars = true;
$oIVI->HideWindowControls = true;
// 0 = Page only
// 1 = Bookmarks Panel and Page
// 2 = Pages Panel and Page
// 3 = Attachments Panel and Page
// 4 = Layers Panel and Page
$oIVI->NavigationTab = 0;

// Page settings
$oIVI->Magnification = 150;
$oIVI->OpenToPage = 2;
// 0 = Default Page Layout
// 1 = Single Page Page Layout
// 2 = Single Page Continoues Page Layout
// 3 = Two-Up (Facing) Page Layout
// 4 = Two-Up Continous (Facing) Page Layout
// 5 = Two-Up (Cover Page) Page Layout
// 6 = Two-Up Continous (Cover Page) Page Layout
$oIVI->PageLayout = 1;

// Release Object
$oIVI = null;

// Populate and flatten the fields, the data will remain in the place
// of the field and the field data will be added to the XMP data
$oTK->SetFormFieldData("name", "John Doe", -997);
$oTK->SetFormFieldData("date", "1/1/2000", -997);
$oTK->SetFormFieldData("amount", "15.00", -997);

// Copy the template (with any changes) to the new file
$intCopyForm = $oTK->CopyForm(0, 0);
if ($intCopyForm != 1) {
  Error("CopyForm", $intCopyForm);
}

// Close the new file to complete PDF creation
$oTK->CloseOutputFile();

// Release Object
$oTK = null;

// Process Complete
echo "Done!";

// Error Handling
function Error($method, $outputCode) {
  echo "Error in " . $method . ": " . $outputCode;
}
?>