<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Toolkit 2011 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, intOpenOutputFile, intOpenInputFile, intCopyForm

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oTK = Server.CreateObject("APToolkit.Object")

' Here you can place any code that will alter the output file
' Such as adding security, setting page dimensions, etc.

' Create the new PDF file
intOpenOutputFile = oTK.OpenOutputFile(strPath & "new.pdf")
If intOpenOutputFile <> 0 Then
  ErrorHandler "OpenOutputFile", intOpenOutputFile
End If

' Open the template PDF
intOpenInputFile = oTK.OpenInputFile(strPath & "PDF.pdf")
If intOpenInputFile <> 0 Then
  ErrorHandler "OpenInputFile", intOpenInputFile
End If

' Here you can call any Toolkit functions that will manipulate
' the input file such as text and image stamping, form filling, etc.

' Copy the template (with any changes) to the new file
' Start page and end page, 0 = all pages
intCopyForm = oTK.CopyForm(0, 0)
If intCopyForm <> 1 Then
  ErrorHandler "CopyForm", intCopyForm
End If

' Close the new file to complete PDF creation
oTK.CloseOutputFile 

' Release Object
Set oTK = Nothing

' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, outputCode)
  Response.Write("Error in " & method & ": " & outputCode)
End Sub
%>