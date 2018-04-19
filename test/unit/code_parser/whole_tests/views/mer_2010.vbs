' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Meridian 2010
' Example generated 01/01/2000 

Dim FSO, intWait

' Instantiate Object
Set oMER = CreateObject("APMeridian.Object")

intWait = oMER.Wait(30)
If intWait <> 0 Then
  ErrorHandler "Wait", intWait
End If

' Release Object
Set oMER = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, outputCode)
  Wscript.Echo("Error in " & method & ": " & outputCode)
End Sub