' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF OCR 2017
' Example generated 01/01/2000 

Imports System
Imports System.IO
Imports System.Net
Imports System.Net.Http
Imports System.Net.Http.Headers

Public Class Examples
  Sub Example()
    Dim Folder As String = AppDomain.CurrentDomain.BaseDirectory
    Dim InputFile As String = Folder + "multipage.tif"
    Dim OutputFile As String = Folder + "new.pdf"
    Dim result As String = String.Empty
    
    Using client As New HttpClient()
        Dim token As String = String.Empty
        Dim uri As New Uri("http://localhost:62625/api/OCR/Conversion")
    
        ' Set the Access Token for authorization
        token = "<<insert token here>>"
        Dim ahv As New AuthenticationHeaderValue("Bearer", token)
        client.DefaultRequestHeaders.Authorization = ahv
    
        ' Multipart form post
        Dim content As New MultipartFormDataContent()
    
        ' Input file as a file stream
        Dim fs As FileStream = File.OpenRead(InputFile)
        Dim streamContent As New StreamContent(fs)
        streamContent.Headers.Add("Content-Type", "application/octet-stream")
        streamContent.Headers.Add("Content-Disposition", "form-data; name=""InputFile""; filename=""" + Path.GetFileName(InputFile) + """")
        content.Add(streamContent, "InputFile", Path.GetFileName(InputFile))
    
        ' Each setting can be passed in here as a new StringContent
        content.Add(New StringContent("0"), "OCRType")
        content.Add(New StringContent("1"), "PictureHandling")
        content.Add(New StringContent("4"), "PDFVersion")
        content.Add(New StringContent("1"), "Linearize")
    
        ' Post the content to the endpoint (uri)
        Dim hrm As HttpResponseMessage = client.PostAsync(uri, content).Result
        If hrm.StatusCode = HttpStatusCode.OK Then
            ' Get the resulting output of the post which is the PDF file created with OCR
            Dim bytes As Byte() = hrm.Content.ReadAsByteArrayAsync().Result
    
            ' Specify where to save the PDF
            File.WriteAllBytes(OutputFile, bytes)
        Else
            ' Get the error message if something went wrong
            Dim errorMsg As String = hrm.Content.ReadAsStringAsync().Result
            WriteResults(errorMsg)
        End If
    End Using
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