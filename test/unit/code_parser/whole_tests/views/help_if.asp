<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Server 2009 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim asdf, some_var, testVar

If asdf = 0 Then
  ' If testVar is 0 then call stop printing
  .Whatever "input.pdf", 0, "output.pdf"
End If
If some_var < 0 Then
  .conmment "This will execute if the if is true"
Else
  ' This will execute if it's false
End If
If testVar = 0 Then
  .StartPrinting = "123"
End If
' Process Complete
Response.Write "Done!"

%>