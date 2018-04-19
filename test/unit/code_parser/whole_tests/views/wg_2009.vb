' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF WebGrabber Enterprise 2009
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim intDoPrint As Integer

    ' Instantiate Object
    Dim oWG As APWebGrbNET.APWebGrabber = New APWebGrbNET.APWebGrabber()
    
    ' Perform the HTML to PDF conversion
    intDoPrint = oWG.DoPrint("127.0.0.1", 54545)
    If intDoPrint <> 0 Then
      ErrorHandler("DoPrint", intDoPrint)
    End If
    
    ' Cleans up all internal string variables used during conversion
    ' By default variables are deleted 3 minutes after the conversion
    oWG.CleanUp("127.0.0.1", 54545)
    
    ' Release Object
    oWG = Nothing
    
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