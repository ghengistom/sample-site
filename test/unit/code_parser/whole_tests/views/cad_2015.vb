' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF CADConverter 2015
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim cadXML As String, strPath As String, results As DCDK.Results.DocConverterResult

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oDC As APDocConverter.DocConverter = New APDocConverter.DocConverter()
    
    ' Settings specific to CAD conversions
    Dim oCAD As APDocConverter.CADConverter.CADConverter = New APDocConverter.CADConverter.CADConverter()
    
    ' Options available for CAD conversions
    ' Options that are 'NotSet' use the setting from the configuation manager
    oCAD.ASCIIHexEncoding = false
    oCAD.Color = APDocConverter.CADConverter.ColorMode.NotSet
    oCAD.EmbedFonts = APDocConverter.CADConverter.EmbedFontsOptions.NotSet
    oCAD.ExportLayers = APDocConverter.CADConverter.LayersOptions.NotSet
    oCAD.ExportLayouts = APDocConverter.CADConverter.LayoutsOptions.NotSet
    oCAD.FlateCompression = false
    oCAD.HatchToBitmapDPI = 150
    oCAD.HiddenLineRemoval = false
    oCAD.Lineweight = APDocConverter.CADConverter.LineweightOptions.NotSet
    oCAD.OtherHatchesSettings = APDocConverter.CADConverter.OtherHatchOptions.NotSet
    oCAD.PlotStyleTableName = ""
    oCAD.SHXTextAsGeometry = false
    oCAD.SimpleGeometryOptimization = false
    oCAD.SolidHatchesSettings = APDocConverter.CADConverter.SolidHatchOptions.NotSet
    oCAD.TrueTypeAsGeometry = false
    oCAD.ZoomToExtents = true
    
    ' Page size is only set if ZoomToExtents is true
    oCAD.SetExtentsPageSize(210, 297)
    
    ' Convert the settings to XML and send it to DocConverter
    cadXML = oCAD.Serialize()
    oDC.SetAddonOptions(cadXML)
    
    ' Release Object
    oCAD = Nothing
    
    ' Convert the file to PDF
    ' If the output parameter is not used the created PDF will use
    ' the input string substituting the filename extension to 'pdf'
    results = oDC.ConvertToPDF(strPath & "sample.dwg", strPath & "new.pdf")
    If results.DocConverterStatus <> DCDK.Results.DocConverterStatus.Success Then
      ErrorHandler("ConvertToPDF", results, results.DocConverterStatus.ToString())
    End If
    
    ' Release Object
    oDC = Nothing
    
    ' Process Complete
    WriteResults("Done!")
  End Sub
  
  ' Error Handling
  Sub ErrorHandler(ByVal strMethod As String, ByVal results As ADK.Results.Result, ByVal errorStatus As String)
    WriteResults("Error with " + strMethod)
    WriteResults(errorStatus)
    WriteResults(results.Details)
    If results.Origin.Function <> strMethod Then
      WriteResults(results.Origin.Class + "." + results.Origin.Function)
    End If
    If Not results.ResultException Is Nothing Then
      ' To view the stack trace on an exception uncomment the line below
      'WriteResults(results.ResultException.StackTrace)
    End If
    Environment.Exit(1)
  End Sub
  
  ' Write output data
  Sub WriteResults(content As String)
    ' Choose where to write out results
  
    ' Debug output
    'System.Diagnostics.Debug.WriteLine("ActivePDF: * " + content)
  
    ' Console
    Console.WriteLine(content)
  
    ' Log file
    'Using tw = New System.IO.StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "application.log", True)
    '   tw.WriteLine("[" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "]: => " + content)
    'End Using
  End Sub
End Class