' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Imports System

Public Class Examples
  Sub Example()
    Dim asdf As Integer, some_var As Integer, testVar As String

    If asdf = 0 Then
      ' If testVar is 0 then call stop printing
      .Whatever("input.pdf", 0, "output.pdf")
    End If
    If some_var < 0 Then
      .conmment("This will execute if the if is true")
    Else
      ' This will execute if it's false
    End If
    If testVar = 0 Then
      .StartPrinting = "123"
    End If
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