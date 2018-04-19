<?php
// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF DocConverter 2015
// Example generated 01/01/2000 
?>

<?php
// Instantiate Object
$oDC = new COM("APDocConverter.Object");

// Release object: .NET = Yes, COM = Yes
$oOne = new COM("APDocConverter.FromPDFOptions");
$oOne->ToWordHeadersAndFootersMode = 0;
$oDC->SetFromPDFOptions($oOne);

// Release Object
$oOne = null;

// Release object: .NET = No, COM = Yes
$oTwo = new COM("APDocConverter.FromPDFOptions");
$oTwo->ToWordHeadersAndFootersMode = 0;
$oDC->SetFromPDFOptions($oTwo);

// Release Object
$oTwo = null;

// Release object: .NET = Yes, COM = Yes
$oThree = new COM("APDocConverter.FromPDFOptions");
$oThree->ToWordHeadersAndFootersMode = 0;
$oDC->SetFromPDFOptions($oThree);

// Release Object
$oThree = null;

// Release Object
$oDC = null;

// Process Complete
echo "Done!";
?>