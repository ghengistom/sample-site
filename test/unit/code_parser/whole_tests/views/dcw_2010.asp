<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF DocConverter WBE 2010 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, intConvertToPDF

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oDCw = Server.CreateObject("DocConverterWBE.Object")

intConvertToPDF = oDCw.ConvertToPDF(strPath & "word.doc", strPath & "word.pdf")
If intConvertToPDF <> 0 Then
  ErrorHandler "ConvertToPDF", intConvertToPDF
End If

' Release Object
Set oDCw = Nothing

' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, outputCode)
  Response.Write("Error in " & method & ": " & outputCode)
End Sub
%>