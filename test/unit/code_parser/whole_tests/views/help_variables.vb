' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Imports System

Public Class Examples
  Sub Example()
    Dim strVariable As String, strText As String, y As Integer, shortVariable As Integer, _
      longVariable As Integer, floatVariable As Single, boolVariable As Boolean, byteVariable As byte, _
      arrayNames As Array, arrayFiles() As String, strPath As String, arrayFiles2() As String, _
      arrayFloats() As Double, arrayPoints() As PointF, ExtractedText As XDK.Results.TextResult, strURL As String, _
      text As String, AddBookmarksOutput As Integer

    strPath = AppDomain.CurrentDomain.BaseDirectory

    strText = "asdf asdf"
    y = 10
    shortVariable = 30000
    longVariable = 100000
    floatVariable = 46.72
    boolVariable = true
    arrayNames = {"James", "John"}
    arrayFiles = {"asdf.pdf", "asdf1.pdf"}
    arrayFiles2 = {strPath & "cover.pdf", "5pageLI.pdf", "6pageAA.pdf"}
    arrayFloats = {4.2, 6.7, 1.3, 9.3}
    arrayPoints = {new PointF(210.0, 776.0), new PointF(246.0, 776.0), new PointF(210.0, 740.0), new PointF(246.0, 740.0)}
    .Debug = boolVariable
    .AddURLBookmark("activePDF.com", strURL)
    text = "asdf" & "1235" & strPath & "asdf.pdf"
    AddBookmarksOutput = .AddBookmarks("asdf", 0, "some_page")
    ' Process Complete
    WriteResults("Done!")
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