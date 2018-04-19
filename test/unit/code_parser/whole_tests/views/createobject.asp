<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF DocConverter 2015 -->
<!-- Example generated 01/01/2000  -->

<%%
' Instantiate Object
Set oDC = Server.CreateObject("APDocConverter.Object")

' Release object: .NET = Yes, COM = Yes
Set oOne = Server.CreateObject("APDocConverter.FromPDFOptions")
oOne.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions oOne

' Release Object
Set oOne = Nothing

' Release object: .NET = No, COM = Yes
Set oTwo = Server.CreateObject("APDocConverter.FromPDFOptions")
oTwo.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions oTwo

' Release Object
Set oTwo = Nothing

' Release object: .NET = Yes, COM = Yes
Set oThree = Server.CreateObject("APDocConverter.FromPDFOptions")
oThree.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions oThree

' Release Object
Set oThree = Nothing

' Release Object
Set oDC = Nothing

' Process Complete
Response.Write "Done!"

%>