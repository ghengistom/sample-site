' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Xtractor 2015
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String, results As XDK.Results.XtractorResultDK.Results.XDK.Results.XtractorResultResult

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oXT As APXtractor.Xtractor = New APXtractor.Xtractor()
    
    results = oXT.OpenPDF(strPath & "PDF.pdf")
    If results.XDK.Results.XtractorResultStatus <> XDK.Results.XtractorResultDK.Results.XDK.Results.XtractorResultStatus.Success Then
      ErrorHandler("OpenPDF", results, results.XDK.Results.XtractorResultStatus.ToString())
    End If
    
    ' Release Object
    oXT = Nothing
    
    ' Process Complete
    WriteResults("Done!")
  End Sub
  
  ' Error Handling
  Sub ErrorHandler(ByVal strMethod As String, ByVal results As ADK.Results.Result, ByVal errorStatus As String)
    WriteResults("Error with " + strMethod)
    WriteResults(errorStatus)
    WriteResults(results.Details)
    If results.Origin.Function <> strMethod Then
      WriteResults(results.Origin.Class + "." + results.Origin.Function)
    End If
    If Not results.ResultException Is Nothing Then
      ' To view the stack trace on an exception uncomment the line below
      'WriteResults(results.ResultException.StackTrace)
    End If
    Environment.Exit(1)
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