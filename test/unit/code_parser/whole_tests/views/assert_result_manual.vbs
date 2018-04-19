' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Xtractor 2015
' Example generated 01/01/2000 

Dim FSO, strPath, results, ExtractedText

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

results = oXT.OpenPDF(strPath & "PDF.pdf")
If results.XtractorStatus <> XDK.Results.XtractorStatus.Success Then
  ErrorHandler "OpenPDF", results, results.XtractorStatus
Else
  ExtractedText = oXT.GetTextByLocation(2, 100, 400, 200)
End If
oXT.ClosePDF 

' Release Object
Set oXT = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, oResult, errorStatus)
  Wscript.Echo("Error with " & method & ": " & vbcrlf _
    & errorStatus & vbcrlf _
    & oResult.details)
  Wscript.Quit 1
End Sub