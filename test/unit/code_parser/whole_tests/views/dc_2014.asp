<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF DocConverter 2014 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, results

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oDC = Server.CreateObject("APDocConverter.Object")

Set results = oDC.ConvertToPDF(strPath & "word.doc", strPath & "word.pdf")
If results.DocConverterStatus <> 0 Then
  ErrorHandler "ConvertToPDF", results, results.DocConverterStatus
End If

Set results = oDC.ConvertFromPDF(strPath & "word.pdf", strPath & "word.pdf", 1)
If results.DocConverterStatus <> 0 Then
  ErrorHandler "ConvertFromPDF", results, results.DocConverterStatus
End If

' Release Object
Set oDC = Nothing

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