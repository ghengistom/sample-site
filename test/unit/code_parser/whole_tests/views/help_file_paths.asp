<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Server 2009 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, intImageToPDF

strPath = Server.MapPath(".") & "\"

intImageToPDF = .ImageToPDF(strPath & "IMG.jpg", strPath & "IMG.pdf")
If intImageToPDF <> 1 Then
  ErrorHandler "ImageToPDF", intImageToPDF
End If
' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, outputCode)
  Response.Write("Error in " & method & ": " & outputCode)
End Sub
%>