<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF CADConverter 2015 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim cadXML, strPath, results

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set oDC = Server.CreateObject("APDocConverter.Object")

' Settings specific to CAD conversions
Set oCAD = Server.CreateObject("CADConverter.Object")

' Options available for CAD conversions
oCAD.ASCIIHexEncoding = false
oCAD.Color = 0
oCAD.EmbedFonts = 2
oCAD.ExportLayers = 2
oCAD.ExportLayouts = 0
oCAD.FlateCompression = false
oCAD.HatchToBitmapDPI = 150
oCAD.HiddenLineRemoval = false
oCAD.Lineweight = -1
oCAD.OtherHatchesSettings = 0
oCAD.PlotStyleTableName = ""
oCAD.SHXTextAsGeometry = false
oCAD.SimpleGeometryOptimization = false
oCAD.SolidHatchesSettings = 2
oCAD.TrueTypeAsGeometry = false
oCAD.ZoomToExtents = true

' Page size is only set if ZoomToExtents is true
oCAD.SetExtentsPageSize 210, 297

' Convert the settings to XML and send it to DocConverter
cadXML = oCAD.Serialize()
oDC.SetAddonOptions cadXML

' Release Object
Set oCAD = Nothing

' Convert the file to PDF
Set results = oDC.ConvertToPDF(strPath & "sample.dwg", strPath & "new.pdf")
If results.DocConverterStatus <> 0 Then
  ErrorHandler "ConvertToPDF", results, results.DocConverterStatus
End If

' Release Object
Set oDC = Nothing

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