' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Dim FSO, strPath, intImageToPDF

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

intImageToPDF = .ImageToPDF(strPath & "IMG.jpg", strPath & "IMG.pdf")
If intImageToPDF <> 1 Then
  ErrorHandler "ImageToPDF", intImageToPDF
End If
' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, outputCode)
  Wscript.Echo("Error in " & method & ": " & outputCode)
End Sub