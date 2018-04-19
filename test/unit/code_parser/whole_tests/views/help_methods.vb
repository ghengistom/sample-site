' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Imports System

Public Class Examples
  Sub Example()
    Dim intStartPrinting As Integer, results As ServerDK.Results.ServerResult, strPath As String, intBeginStartPrinting As Integer, _
      ManualResults As XDK.Results.XtractorResult, ExtractedText As XDK.Results.TextResult, intSetDocumentProperty As Integer

    strPath = AppDomain.CurrentDomain.BaseDirectory

    .MethodName("asdf", "#FF9900", 1, 2.0, true)
    .AddEmail()
    intStartPrinting = .StartPrinting("file.ps", "file.pdf")
    If intStartPrinting <> 0 Then
      ErrorHandler("StartPrinting", intStartPrinting)
    End If
    intStartPrinting = .StartPrinting("file.ps", "file.pdf")
    If intStartPrinting < 1 Then
      ErrorHandler("StartPrinting", intStartPrinting)
    End If
    intStartPrinting = .StartPrinting("file.ps", "file.pdf")
    If intStartPrinting > 1 Then
      ErrorHandler("StartPrinting", intStartPrinting)
    End If
    results = .StartPrinting("file.ps", "file.pdf")
    If results.ServerStatus <> ServerDK.Results.ServerStatus.Success Then
      ErrorHandler("StartPrinting", results, results.ServerStatus.ToString())
    End If
    results = .ClosePDF()
    If results.ServerStatus <> ServerDK.Results.ServerStatus.Success Then
      ErrorHandler("ClosePDF", results, results.ServerStatus.ToString())
    End If
    intBeginStartPrinting = .BeginStartPrinting(strPath & "file.ps", strPath & "file.pdf")
    If intBeginStartPrinting <> 0 Then
      ErrorHandler("BeginStartPrinting", intBeginStartPrinting)
    End If
    intBeginStartPrinting = .BeginStartPrinting("file.ps", "file.pdf")
    If intBeginStartPrinting < 1 Then
      ErrorHandler("BeginStartPrinting", intBeginStartPrinting)
    End If
    ErrorHandler("MethodName", VariableName)
    ManualResults = .OpenPDF(strPath & "Report.pdf")
    If results.XtractorStatus <> XDK.Results.XtractorStatus.Success Then
      ErrorHandler("OpenPDF", ManualResults, ManualResults.XtractorStatus.ToString())
    Else
      ExtractedText = .GetTextByLocation(2, 100, 400, 200)
    End If
    Dim oXMP As APToolkitNET.XMPManager = .GetXMPManager()
    ' Set a document property
    intSetDocumentProperty = oXMP.SetDocumentProperty(NameSpace.XMPProperty.Author, "John Doe")
    If intSetDocumentProperty <> 0 Then
      ErrorHandler("SetDocumentProperty", intSetDocumentProperty)
    End If
    intSetDocumentProperty = oXMP.SetDocumentProperty(APToolkitNET.XMPProperty.Author, "John Doe")
    If intSetDocumentProperty <> 0 Then
      ErrorHandler("SetDocumentProperty", intSetDocumentProperty)
    End If
    intSetDocumentProperty = oXMP.SetDocumentProperty(NameSpace.XMPTest.Author, NameSpace.XMPTest.Title)
    If intSetDocumentProperty <> 0 Then
      ErrorHandler("SetDocumentProperty", intSetDocumentProperty)
    End If
    oXMP.RemoveDocumentProperty(NameSpace.XMPProperty.Author)
    
    ' Release Object
    oXMP = Nothing
    Dim oReleaseOne As Product.Class = .MethodObject()
    
    ' Release Object
    oReleaseOne = Nothing
    Dim oReleaseTwo As Product.Class = .MethodObject()
    
    ' Release Object
    oReleaseTwo = Nothing
    Dim oNoRelease As Product.Class = .MethodObject()
    ' Process Complete
    WriteResults("Done!")
  End Sub
  
  ' Error Handling
  ' Error messages written to debug output
  Sub ErrorHandler(ByVal strMethod, ByVal RtnCode)
    WriteResults(strMethod + " error:  " + rtnCode.ToString())
  End Sub
  
  ' Write output data
  Sub WriteResults(content As String)
    ' Choose where to write out results
  
    ' Debug output
    'System.Diagnostics.Debug.WriteLine("ActivePDF: * " + content)
  
    ' Console
    Console.WriteLine(content)
  
    ' Log file
    'Using tw = New System.IO.StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "application.log", True)
    '   tw.WriteLine("[" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "]: => " + content)
    'End Using
  End Sub
End Class