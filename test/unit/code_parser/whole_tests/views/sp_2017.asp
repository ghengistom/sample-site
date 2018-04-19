<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Spooler 2017 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim arrayAvailableDPIs, arrayBinSources, isCollate, valColorMode, _
 valDPI, valDuplex, arrayFormNames, valOrientation, _
 arrayPaperSizes, valPrinterName, valTrueType, strPath, _
 results

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set objVAR = Server.CreateObject("APProduct.Object")

' Use the PrinterInfo object to retrieve current settings
' and available options for the specified printer.
Set oPI = objVAR.PrinterInfo("Microsoft Print to PDF")

arrayAvailableDPIs = oPI.AvailableDPI
arrayBinSources = oPI.BinSources
isCollate = oPI.Collate
valColorMode = oPI.ColorMode
valDPI = oPI.DPI
valDuplex = oPI.Duplex
arrayFormNames = oPI.FormNames
valOrientation = oPI.Orientation
arrayPaperSizes = oPI.PaperSizes
valPrinterName = oPI.PrinterName
valTrueType = oPI.TrueTypeOption

' Release Object
Set oPI = Nothing

' Use the PrintJobProfile object to set specific printer settings
' for the print job if the default options are not what is needed.
Set oPJP = objVAR.PrintJobProfile("SettingsOne")

oPJP.BinSource = 15
oPJP.Collate = false
oPJP.ColorMode = 2
oPJP.DPI = 300
oPJP.Duplex = 1
oPJP.FormName = "SampleForm"
oPJP.Nup = 0
oPJP.Orientation = 1
oPJP.PaperSize = 1
oPJP.PrinterName = "Microsoft Print to PDF"
oPJP.PrintOddEvenAll = 3
oPJP.ProfileName = "SettingsOne"
oPJP.Scaling = 1
oPJP.CustomScaling = 95.0
oPJP.TrueTypeOption = 3

' File specific settings
objVAR.Copies = 1
objVAR.PageRange = "1-2,4"
objVAR.PrintAnnotations = true

' Print directly to a printer. Leave first parameter blank for default printer
Set results = objVAR.PrintFileCustom(oPJP, strPath & "5pageLI.pdf", "")
If results.Status <> 0 Then
  ErrorHandler "PrintFileCustom", results, results.Status
End If

' Release Object
Set oPJP = Nothing

' Release Object
Set objVAR = Nothing

' Process Complete
Response.Write "Done!"

' Error Handling
Sub ErrorHandler(method, oResult, errorStatus)
  Response.Write("Error with " & method & ": <br/>" _
    & errorStatus & "<br/>" _
    & oResult.details)
  Response.End
End Sub
%>