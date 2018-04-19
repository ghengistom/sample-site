' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Rasterizer 2017
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String, pageCount As Integer, currentPage As Integer

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim objVAR As NameSpace.Class = New NameSpace.Class()
    
    ' Open PDF
    objVAR.OpenFile(strPath & "doc.pdf")
    
    ' Get page count of open file
    pageCount = objVAR.NumPages()
    
    For currentPage = 1 To pageCount
      ' Image Format
      objVAR.ImageFormat = NameSpace.ImageType.ImgJPEG
      
      ' Output Type
      objVAR.OutputFormat = NameSpace.OutputFormatType.OutFile
      
      ' Other settings
      objVAR.OutputFileName = strPath & "doc" & currentPage & ".jpg"
      objVAR.JPEGQuality = 72
      objVAR.IncludeAnnotations = true
      
      ' Render the current page
      objVAR.RenderPage(currentPage)
    Next
    
    ' Finished rendering pages, close file
    objVAR.CloseFile()
    
    ' Release Object
    objVAR.Dispose()
    
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