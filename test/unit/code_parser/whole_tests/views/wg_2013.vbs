' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF WebGrabber 2016
' Example generated 01/01/2000 

Dim FSO, results

' Instantiate Object
Set oWG = CreateObject("APWebGrabber.Object")

Set results = oWG.ConvertToPDF("127.0.0.1", 90)
If results.WebGrabberStatus <> 0 Then
  ErrorHandler "ConvertToPDF", results, results.WebGrabberStatus
End If

' Release Object
Set oWG = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, oResult, errorStatus)
  Wscript.Echo("Error with " & method & ": " & vbcrlf _
    & errorStatus & vbcrlf _
    & oResult.details)
  Wscript.Quit 1
End Sub