<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Server 2009 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, intPSToPDF

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oSVR = Server.CreateObject("APServer.Object")

intPSToPDF = oSVR.PSToPDF(strPath & "ps.ps", strPath & "ps.pdf")
If intPSToPDF <> 0 Then
  ErrorHandler "PSToPDF", intPSToPDF
End If

' Release Object
Set oSVR = Nothing

' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, outputCode)
  Response.Write("Error in " & method & ": " & outputCode)
End Sub
%>