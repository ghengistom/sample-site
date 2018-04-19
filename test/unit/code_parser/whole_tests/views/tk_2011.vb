' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Toolkit 2011
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String, intOpenOutputFile As Integer, intOpenInputFile As Integer, intCopyForm As Integer

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oTK As APToolkitNET.Toolkit = New APToolkitNET.Toolkit()
    
    ' Here you can place any code that will alter the output file
    ' Such as adding security, setting page dimensions, etc.
    
    ' Create the new PDF file
    intOpenOutputFile = oTK.OpenOutputFile(strPath & "new.pdf")
    If intOpenOutputFile <> 0 Then
      ErrorHandler("OpenOutputFile", intOpenOutputFile)
    End If
    
    ' Open the template PDF
    intOpenInputFile = oTK.OpenInputFile(strPath & "PDF.pdf")
    If intOpenInputFile <> 0 Then
      ErrorHandler("OpenInputFile", intOpenInputFile)
    End If
    
    ' Here you can call any Toolkit functions that will manipulate
    ' the input file such as text and image stamping, form filling, etc.
    
    ' Copy the template (with any changes) to the new file
    ' Start page and end page, 0 = all pages
    intCopyForm = oTK.CopyForm(0, 0)
    If intCopyForm <> 1 Then
      ErrorHandler("CopyForm", intCopyForm)
    End If
    
    ' Close the new file to complete PDF creation
    oTK.CloseOutputFile()
    
    ' Release Object
    oTK.Dispose()
    
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