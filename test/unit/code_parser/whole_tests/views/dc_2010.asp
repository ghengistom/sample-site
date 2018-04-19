<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF DocConverter Enterprise 2010 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, intSubmit

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oDC = Server.CreateObject("APDocConv.Object")

intSubmit = oDC.Submit("127.0.0.1", 58585, strPath & "word.doc", strPath, strPath, strPath, "", "", false, "")
If intSubmit <> 0 Then
  ErrorHandler "Submit", intSubmit
End If

' Release Object
Set oDC = Nothing

' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, outputCode)
  Response.Write("Error in " & method & ": " & outputCode)
End Sub
%>