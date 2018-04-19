' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String, intPSToPDF As Integer

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oSVR As APServer.Server = New APServer.Server()
    
    intPSToPDF = oSVR.PSToPDF(strPath & "ps.ps", strPath & "ps.pdf")
    If intPSToPDF <> 0 Then
      ErrorHandler("PSToPDF", intPSToPDF)
    End If
    
    ' Release Object
    oSVR = Nothing
    
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