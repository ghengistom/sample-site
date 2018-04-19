<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Server 2012 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, results

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oSVR = Server.CreateObject("APServer.Object")

' Convert the PostScript file into PDF
Set results = oSVR.ConvertPSToPDF(strPath & "file.ps", strPath & "file.pdf")
If results.ServerStatus <> 0 Then
  ErrorHandler "ConvertPSToPDF", results, results.ServerStatus
End If

' Release Object
Set oSVR = Nothing

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