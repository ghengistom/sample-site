' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Dim FSO, strPath, intPSToPDF

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

' Instantiate Object
Set oSVR = CreateObject("APServer.Object")

intPSToPDF = oSVR.PSToPDF(strPath & "ps.ps", strPath & "ps.pdf")
If intPSToPDF <> 0 Then
  ErrorHandler "PSToPDF", intPSToPDF
End If

' Release Object
Set oSVR = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, outputCode)
  Wscript.Echo("Error in " & method & ": " & outputCode)
End Sub