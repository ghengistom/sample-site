' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter Enterprise 2010
' Example generated 01/01/2000 

Dim FSO, strPath, intSubmit

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

' Instantiate Object
Set oDC = CreateObject("APDocConv.Object")

intSubmit = oDC.Submit("127.0.0.1", 58585, strPath & "word.doc", strPath, strPath, strPath, "", "", false, "")
If intSubmit <> 0 Then
  ErrorHandler "Submit", intSubmit
End If

' Release Object
Set oDC = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, outputCode)
  Wscript.Echo("Error in " & method & ": " & outputCode)
End Sub