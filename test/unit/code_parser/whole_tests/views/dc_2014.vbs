' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter 2014
' Example generated 01/01/2000 

Dim FSO, strPath, results

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

' Instantiate Object
Set oDC = CreateObject("APDocConverter.Object")

Set results = oDC.ConvertToPDF(strPath & "word.doc", strPath & "word.pdf")
If results.DocConverterStatus <> 0 Then
  ErrorHandler "ConvertToPDF", results, results.DocConverterStatus
End If

Set results = oDC.ConvertFromPDF(strPath & "word.pdf", strPath & "word.pdf", 1)
If results.DocConverterStatus <> 0 Then
  ErrorHandler "ConvertFromPDF", results, results.DocConverterStatus
End If

' Release Object
Set oDC = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, oResult, errorStatus)
  Wscript.Echo("Error with " & method & ": " & vbcrlf _
    & errorStatus & vbcrlf _
    & oResult.details)
  Wscript.Quit 1
End Sub