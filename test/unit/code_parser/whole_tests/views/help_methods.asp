<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Server 2009 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim intStartPrinting, results, strPath, intBeginStartPrinting, _
 ManualResults, ExtractedText, intSetDocumentProperty

strPath = Server.MapPath(".") & "\"

.MethodName "asdf", "#FF9900", 1, 2.0, true
.AddEmail 
intStartPrinting = .StartPrinting("file.ps", "file.pdf")
If intStartPrinting <> 0 Then
  ErrorHandler "StartPrinting", intStartPrinting
End If
intStartPrinting = .StartPrinting("file.ps", "file.pdf")
If intStartPrinting < 1 Then
  ErrorHandler "StartPrinting", intStartPrinting
End If
intStartPrinting = .StartPrinting("file.ps", "file.pdf")
If intStartPrinting > 1 Then
  ErrorHandler "StartPrinting", intStartPrinting
End If
Set results = .StartPrinting("file.ps", "file.pdf")
If results.ServerStatus <> 0 Then
  ErrorHandler "StartPrinting", results, results.ServerStatus
End If
Set results = .ClosePDF()
If results.ServerStatus <> 0 Then
  ErrorHandler "ClosePDF", results, results.ServerStatus
End If
intBeginStartPrinting = .BeginStartPrinting(strPath & "file.ps", strPath & "file.pdf")
If intBeginStartPrinting <> 0 Then
  ErrorHandler "BeginStartPrinting", intBeginStartPrinting
End If
intBeginStartPrinting = .BeginStartPrinting("file.ps", "file.pdf")
If intBeginStartPrinting < 1 Then
  ErrorHandler "BeginStartPrinting", intBeginStartPrinting
End If
ErrorHandler "MethodName", VariableName
ManualResults = .OpenPDF(strPath & "Report.pdf")
If results.XtractorStatus <> XDK.Results.XtractorStatus.Success Then
  ErrorHandler "OpenPDF", ManualResults, ManualResults.XtractorStatus
Else
  ExtractedText = .GetTextByLocation(2, 100, 400, 200)
End If
Set oXMP = .GetXMPManager()
' Set a document property
intSetDocumentProperty = oXMP.SetDocumentProperty(2, "John Doe")
If intSetDocumentProperty <> 0 Then
  ErrorHandler "SetDocumentProperty", intSetDocumentProperty
End If
intSetDocumentProperty = oXMP.SetDocumentProperty(2, "John Doe")
If intSetDocumentProperty <> 0 Then
  ErrorHandler "SetDocumentProperty", intSetDocumentProperty
End If
intSetDocumentProperty = oXMP.SetDocumentProperty(2, 4)
If intSetDocumentProperty <> 0 Then
  ErrorHandler "SetDocumentProperty", intSetDocumentProperty
End If
oXMP.RemoveDocumentProperty 2

' Release Object
Set oXMP = Nothing
Set oReleaseOne = .MethodObject()

' Release Object
Set oReleaseOne = Nothing
Set oReleaseTwo = .MethodObject()

' Release Object
Set oReleaseTwo = Nothing
Set oNoRelease = .MethodObject()

' Release Object
Set oNoRelease = Nothing
' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, outputCode)
  Response.Write("Error in " & method & ": " & outputCode)
End Sub
%>