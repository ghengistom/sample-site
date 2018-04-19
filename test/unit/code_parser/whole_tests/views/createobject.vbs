' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter 2015
' Example generated 01/01/2000 

Dim FSO

' Instantiate Object
Set oDC = CreateObject("APDocConverter.Object")

' Release object: .NET = Yes, COM = Yes
Set oOne = CreateObject("APDocConverter.FromPDFOptions")
oOne.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions oOne

' Release Object
Set oOne = Nothing

' Release object: .NET = No, COM = Yes
Set oTwo = CreateObject("APDocConverter.FromPDFOptions")
oTwo.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions oTwo

' Release Object
Set oTwo = Nothing

' Release object: .NET = Yes, COM = Yes
Set oThree = CreateObject("APDocConverter.FromPDFOptions")
oThree.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions oThree

' Release Object
Set oThree = Nothing

' Release Object
Set oDC = Nothing

' Process Complete
Wscript.Echo("Done!")
