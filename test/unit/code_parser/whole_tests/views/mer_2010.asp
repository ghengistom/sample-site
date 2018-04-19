<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Meridian 2010 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim intWait

' Instantiate Object
Set oMER = Server.CreateObject("APMeridian.Object")

intWait = oMER.Wait(30)
If intWait <> 0 Then
  ErrorHandler "Wait", intWait
End If

' Release Object
Set oMER = Nothing

' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, outputCode)
  Response.Write("Error in " & method & ": " & outputCode)
End Sub
%>