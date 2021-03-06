' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF WebGrabber WBE 2010
' Example generated 01/01/2000 

Dim FSO, intDoPrint

' Instantiate Object
Set oWG = CreateObject("APWebGrabber.Object")

' Perform the HTML to PDF conversion
intDoPrint = oWG.DoPrint("127.0.0.1", 58585)
If intDoPrint <> 0 Then
  ErrorHandler "DoPrint", intDoPrint
End If

' Cleans up all internal string variables used during conversion
' By default variables are deleted 3 minutes after the conversion
oWG.CleanUp "127.0.0.1", 58585

' Release Object
Set oWG = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, outputCode)
  Wscript.Echo("Error in " & method & ": " & outputCode)
End Sub