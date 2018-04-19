' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter WBE 2010
' Example generated 01/01/2000 

Dim FSO, strPath, intConvertToPDF

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

' Instantiate Object
Set oDCw = CreateObject("DocConverterWBE.Object")

intConvertToPDF = oDCw.ConvertToPDF(strPath & "word.doc", strPath & "word.pdf")
If intConvertToPDF <> 0 Then
  ErrorHandler "ConvertToPDF", intConvertToPDF
End If

' Release Object
Set oDCw = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, outputCode)
  Wscript.Echo("Error in " & method & ": " & outputCode)
End Sub