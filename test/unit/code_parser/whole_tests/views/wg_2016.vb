' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF WebGrabber 2016
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String, results As WebGrabberDK.Results.WebGrabberResult

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oWG As APWebGrabber.WebGrabber = New APWebGrabber.WebGrabber()
    
    ' C:\ProgramData\activePDF\Logs\
    oWG.Debug = true
    
    oWG.LinearizePDF = true
    
    ' Set the amount of time before a request will time out
    oWG.TimeoutSpan = new TimeSpan(0, 0, 40)
    
    ' Margins (Top, Bottom, Left, Right) 1.0 = 1"
    oWG.SetMargins(0.75, 0.75, 0.75, 0.75)
    
    ' 0 = Portrait, 1 = Landscape
    oWG.Orientation = 0
    
    ' Rendering engine used for the HTML
    oWG.EngineToUse = APWebGrabberInterface.ConversionEngine.IE
    
    ' Convert the HTML background (IE engine only)
    oWG.PrintBackground = true
    
    ' PDF output location and filename
    oWG.OutputDirectory = strPath
    oWG.NewDocumentName = "basic.pdf"
    
    ' HTML to convert
    ' Examples:
    ' http://domain.com/path/file.aspx
    ' c:\folder\file.html
    oWG.URL = "http://examples.activepdf.com/samples/doc"
    
    ' Perform the HTML to PDF conversion
    results = oWG.ConvertToPDF()
    If results.WebGrabberStatus <> WebGrabberDK.Results.WebGrabberStatus.Success Then
      ErrorHandler("ConvertToPDF", results, results.WebGrabberStatus.ToString())
    End If
    
    ' Release Object
    oWG = Nothing
    
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