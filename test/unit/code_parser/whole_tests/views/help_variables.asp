<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Server 2009 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strVariable, strText, y, shortVariable, _
 longVariable, floatVariable, boolVariable, byteVariable, _
 arrayNames, arrayFiles, strPath, arrayFiles2, _
 arrayFloats, arrayPoints, ExtractedText, strURL, _
 text, AddBookmarksOutput

strPath = Server.MapPath(".") & "\"

strText = "asdf asdf"
y = 10
shortVariable = 30000
longVariable = 100000
floatVariable = 46.72
boolVariable = true
arrayNames = array("James", "John")
arrayFiles = array("asdf.pdf", "asdf1.pdf")
arrayFiles2 = array(strPath & "cover.pdf", "5pageLI.pdf", "6pageAA.pdf")
arrayFloats = array(4.2, 6.7, 1.3, 9.3)
arrayPoints = array(210.0, 776.0, 246.0, 776.0, 210.0, 740.0, 246.0, 740.0)
.Debug = boolVariable
.AddURLBookmark "activePDF.com", strURL
text = "asdf" & "1235" & strPath & "asdf.pdf"
AddBookmarksOutput = .AddBookmarks("asdf", 0, "some_page")
' Process Complete
Response.Write "Done!"

%>