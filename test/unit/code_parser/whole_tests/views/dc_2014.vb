' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter 2014
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String, results As DCDK.Results.DocConverterResult

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oDC As APDocConverter.DocConverter = New APDocConverter.DocConverter()
    
    results = oDC.ConvertToPDF(strPath & "word.doc", strPath & "word.pdf")
    If results.DocConverterStatus <> DCDK.Results.DocConverterStatus.Success Then
      ErrorHandler("ConvertToPDF", results, results.DocConverterStatus.ToString())
    End If
    
    results = oDC.ConvertFromPDF(strPath & "word.pdf", strPath & "word.pdf", oDC.FromPDFFormat = APDocConverter.FromPDFFunction.ToWord)
    If results.DocConverterStatus <> DCDK.Results.DocConverterStatus.Success Then
      ErrorHandler("ConvertFromPDF", results, results.DocConverterStatus.ToString())
    End If
    
    ' Release Object
    oDC = Nothing
    
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