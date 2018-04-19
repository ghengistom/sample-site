' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter 2015
' Example generated 01/01/2000 

Dim FSO, strPath, results

' Get current path
Set FSO = CreateObject("Scripting.FileSystemObject")
strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & "\"
Set FSO = Nothing

' Instantiate Object
Set oDC = CreateObject("APDocConverter.Object")

' Settings specific to other formats created with from PDF conversions
' are set using the FromPDFOptions object
Set fPDF = CreateObject("APDocConverter.FromPDFOptions")

' To Word options
fPDF.ToWordHeadersAndFootersMode = 0

' To Excel options
fPDF.ToExcelAutoDetectSeparators = true
fPDF.ToExcelTablesFromContent = 0

' To Image options
fPDF.ToImagePageDPI = 300

' Send the from PDF settings to DocConverter
oDC.SetFromPDFOptions fPDF

' Release Object
Set fPDF = Nothing

' Convert the document from PDF to another format
' The second parameter determines the output file format
'  0 = .doc
'  1 = .docx
'  2 = .xls
'  3 = .ppt
'  4 = .html
'  5 = .txt
'  6 = .bmp
'  7 = .jpg
'  8 = .png
'  9 = .tif
' 10 = .pdf (PDF/A)
' 11 = Verify PDF/A compliance
' 12 = .rtf
' 13 = .gif
' 14 = .tif (multipage)
Set results = oDC.ConvertFromPDF(strPath & "PDF.pdf", 1, strPath & "PDF.docx")
If results.DocConverterStatus <> 0 Then
  ErrorHandler "ConvertFromPDF", results, results.DocConverterStatus
End If

' Release Object
Set oDC = Nothing

' Process Complete
Wscript.Echo("Done!")

' Error Handling
Sub ErrorHandler(method, oResult, errorStatus)
  Wscript.Echo("Error with " & method & ": " & vbcrlf _
    & errorStatus & vbcrlf _
    & oResult.details)
  Wscript.Quit 1
End Sub