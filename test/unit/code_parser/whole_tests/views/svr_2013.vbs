' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2013
' Example generated 01/01/2000 

Dim FSO, strPath, results

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

' Instantiate Object
Set oSVR = CreateObject("APServer.Object")

Set results = oSVR.ConvertPSToPDF(strPath & "ps.ps", strPath & "ps.pdf")
If results.ServerStatus <> 0 Then
  ErrorHandler "ConvertPSToPDF", results, results.ServerStatus
End If

' Release Object
Set oSVR = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, oResult, errorStatus)
  Wscript.Echo("Error with " & method & ": " & vbcrlf _
    & errorStatus & vbcrlf _
    & oResult.details)
  Wscript.Quit 1
End Sub