' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Dim FSO, intDoPrint, strPath, intOpenInputFile, _
 strFieldInfo

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

' Instantiate Object
Set objVAR = CreateObject("APProduct.Object")


' Release Object
Set objVAR = Nothing

' Instantiate Object
Set oDC = CreateObject("APDocConv.Object")


' Release Object
Set oDC = Nothing

' Instantiate Object
Set oDCw = CreateObject("DocConverterWBE.Object")


' Release Object
Set oDCw = Nothing

' Instantiate Object
Set oMER = CreateObject("APMeridian.Object")


' Release Object
Set oMER = Nothing

' Instantiate Object
Set oSVR = CreateObject("APServer.Object")


' Release Object
Set oSVR = Nothing

' Instantiate Object
Set oTK = CreateObject("APToolkit.Object")


' Release Object
Set oTK = Nothing

' Instantiate Object
Set oWG = CreateObject("APWebGrabber.Object")


' Release Object
Set oWG = Nothing


' Release Object
Set oXT = Nothing

.with_ 
.with_toolkit 
' Instantiate Object
Set oWG = CreateObject("APWebGrabber.Object")

intDoPrint = oWG.DoPrint("127.0.0.1", 58585)
If intDoPrint <> 0 Then
  ErrorHandler "DoPrint", intDoPrint
End If
' Instantiate Object
Set oTK = CreateObject("APToolkit.Object")

intOpenInputFile = oTK.OpenInputFile(strPath & "new.pdf")
If intOpenInputFile <> 0 Then
  ErrorHandler "OpenInputFile", intOpenInputFile
End If
oWG.Function "asdf"

' Release Object
Set oTK = Nothing


' Release Object
Set oWG = Nothing

' Instantiate Object
Set oDC = CreateObject("APDocConv.Object")

Set fPDF = CreateObject("APDocConverter.FromPDFOptions")
fPDF.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions fPDF

' Release Object
Set fPDF = Nothing

' Release Object
Set oDC = Nothing

Set fPDF = CreateObject("APDocConverter.FromPDFOptions")
fPDF.ToWordHeadersAndFootersMode = 0

' Release Object
Set fPDF = Nothing
' Instantiate Object
Set oDC = CreateObject("APDocConv.Object")

' Snippet with variables
oDC.SetSnippetPropertyToInt = 1
oDC.ArrayProperty = "Array of numbers and strings"
oDC.ArrayProperty = 1
oDC.ArrayProperty = 18.38
' nil

' Release Object
Set oDC = Nothing

Set fPDF = CreateObject("APDocConverter.FromPDFOptions")
fPDF.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions fPDF

' Release Object
Set fPDF = Nothing
Set oXMP = .GetXmpManager()
oXMP.AddFieldsToXMP = 1
Set oXMPField = oXMP.GetXMPFieldInfo("name")
strFieldInfo = oXMPField.Name

' Release Object
Set oXMPField = Nothing

' Release Object
Set oXMP = Nothing
' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, outputCode)
  Wscript.Echo("Error in " & method & ": " & outputCode)
End Sub