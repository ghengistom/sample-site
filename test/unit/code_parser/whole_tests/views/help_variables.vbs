' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Dim FSO, strVariable, strText, y, _
 shortVariable, longVariable, floatVariable, boolVariable, _
 byteVariable, arrayNames, arrayFiles, strPath, _
 arrayFiles2, arrayFloats, arrayPoints, ExtractedText, _
 strURL, text, AddBookmarksOutput

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

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
Wscript.Echo("Done!")
