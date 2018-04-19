' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Imports System

Public Class Examples
  Sub Example()
    Dim isDebug As Boolean, testVar As Integer

    .Debug = "asdf"
    .Debug = 4
    .Debug = true
    .Debug = false
    .Debug = asdf
    .Debug = 0
    .Show = NameSpace.IVShow.IVShow_DocumentTitle
    .EngineToUse = APWebGrabberInterface.ConversionEngine.IE
    isDebug = .Debug
    testVar = .GetUniqueID & ".pdf"
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