' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Imports System

Public Class Examples
  Sub Example()
    ' Snippet with variables
    .SetSnippetPropertyToInt = 1
    .ArrayProperty = "Array of numbers and strings"
    .ArrayProperty = 1
    .ArrayProperty = 18.38
    ' nil
    ' Snippet with variables
    ' Hello World!
    .SetSnippetPropertyToInt = 0
    .ArrayProperty = "Array of strings and numbers"
    .ArrayProperty = 0
    .ArrayProperty = 12.56
    ' nil
    ' Snippet with variables
    ' Hello World!
    .SetSnippetPropertyToInt = 0
    .ArrayProperty = "Array of strings and numbers"
    .ArrayProperty = 0
    .ArrayProperty = 12.56
    ' {"ps"=>["input.ps", "output.ps.pdf"], "xps"=>["input.xps", "output.xps.pdf"]}
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