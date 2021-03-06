<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF WebGrabber 2016 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, results

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oWG = Server.CreateObject("APWebGrabber.Object")

' C:\ProgramData\activePDF\Logs\
oWG.Debug = true

oWG.LinearizePDF = true

' Set the amount of seconds before a request will time out
oWG.Timeout = 40

' Margins (Top, Bottom, Left, Right) 1.0 = 1"
oWG.SetMargins 0.75, 0.75, 0.75, 0.75

' 0 = Portrait, 1 = Landscape
oWG.Orientation = 0

' Rendering engine used for the HTML
' 0 = Native, 1 = IE
oWG.EngineToUse = 1

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
Set results = oWG.ConvertToPDF("127.0.0.1", 52525)
If results.WebGrabberStatus <> 0 Then
  ErrorHandler "ConvertToPDF", results, results.WebGrabberStatus
End If

' Release Object
Set oWG = Nothing

' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, oResult, errorStatus)
  Response.Write("Error with " & method & ": <br/>" _
    & errorStatus & "<br/>" _
    & oResult.details)
  Response.End
End Sub
%>