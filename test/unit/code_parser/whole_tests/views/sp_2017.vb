' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Spooler 2017
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim arrayAvailableDPIs As Array, arrayBinSources As Array, isCollate As Boolean, valColorMode As APSpoolerNET.ColorMode, _
      valDPI As Integer, valDuplex As APSpoolerNET.DuplexMode, arrayFormNames As Array, valOrientation As APSpoolerNET.Orientation, _
      arrayPaperSizes As Array, valPrinterName As String, valTrueType As APSpoolerNET.TrueTypeOptions, strPath As String, _
      results As SpoolerDK.Results.SpoolerResult

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim objVAR As NameSpace.Class = New NameSpace.Class()
    
    ' Use the PrinterInfo object to retrieve current settings
    ' and available options for the specified printer.
    Dim oPI As APSpoolerNET.PrinterInfo = objVAR.PrinterInfo("Microsoft Print to PDF")
    
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
    
    ' Use the PrintJobProfile object to set specific printer settings
    ' for the print job if the default options are not what is needed.
    Dim oPJP As APSpoolerNET.PrinterProfile = objVAR.PrintJobProfile("SettingsOne")
    
    oPJP.BinSource = 15
    oPJP.Collate = false
    oPJP.ColorMode = NameSpace.ColorMode.Color
    oPJP.DPI = 300
    oPJP.Duplex = NameSpace.DuplexMode.Simplex
    oPJP.FormName = "SampleForm"
    oPJP.Nup = 0
    oPJP.Orientation = NameSpace.Orientation.Portrait
    oPJP.PaperSize = NameSpace.PaperSize.Letter
    oPJP.PrinterName = "Microsoft Print to PDF"
    oPJP.PrintOddEvenAll = NameSpace.PrintPages.AllPages
    oPJP.ProfileName = "SettingsOne"
    oPJP.Scaling = NameSpace.PrintScaling.Custom
    oPJP.CustomScaling = 95.0
    oPJP.TrueTypeOption = NameSpace.TrueTypeOptions.Substitute
    
    ' File specific settings
    objVAR.Copies = 1
    objVAR.PageRange = "1-2,4"
    objVAR.PrintAnnotations = true
    
    ' Print a PDF
    results = objVAR.PrintFile(oPJP, strPath & "5pageLI.pdf")
    If results.SpoolerStatus <> SpoolerDK.Results.SpoolerStatus.Success Then
      ErrorHandler("PrintFile", results, results.SpoolerStatus.ToString())
    End If
    
    ' Release Object
    objVAR = Nothing
    
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