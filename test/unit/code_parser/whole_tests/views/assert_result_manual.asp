<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Xtractor 2015 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, results, ExtractedText

strPath = Server.MapPath(".") & "\"

results = oXT.OpenPDF(strPath & "PDF.pdf")
If results.XtractorStatus <> XDK.Results.XtractorStatus.Success Then
  ErrorHandler "OpenPDF", results, results.XtractorStatus
Else
  ExtractedText = oXT.GetTextByLocation(2, 100, 400, 200)
End If
oXT.ClosePDF 

' Release Object
Set oXT = Nothing

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