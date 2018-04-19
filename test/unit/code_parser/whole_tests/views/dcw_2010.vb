' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter WBE 2010
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oDCw As activePDF.API.DocConverterWBE.DocConverter = New activePDF.API.DocConverterWBE.DocConverter()
    
    Dim irSuccess As IResult = New Result(Code.Success, "ConvertToPDF")
    Dim intConvertToPDF As IResult = oDCw.ConvertToPDF(strPath & "word.doc", strPath & "word.pdf")
    If intConvertToPDF.Status <> irSuccess.Status Then
    ErrorHandler("ConvertToPDF", intConvertToPDF.Status & " - " & intConvertToPDF.Details)
    End If
    
    ' Release Object
    oDCw = Nothing
    
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