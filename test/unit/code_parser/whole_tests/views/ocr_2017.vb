' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF OCR 2017
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.
Imports OCRData.Enums.ImageProcessing
Imports OCRData.Enums.OCR
Imports OCRData.Enums.PDF
Imports ConverterKit.DK.Enums.PDF

Public Class Examples
  Sub Example()
    Dim strPath As String, results As OCRDK.Results.OCRResult

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim objVAR As NameSpace.Class = New NameSpace.Class()
    
    ' OCR Settings
    objVAR.Settings.OCR.Deskew = DeskewOptions.Auto2D
    objVAR.Settings.OCR.Despeckled = true
    objVAR.Settings.OCR.ExportBookmarks = false
    objVAR.Settings.OCR.OCRType = OCRTypeOptions.SearchablePDF
    objVAR.Settings.OCR.PictureHandling = PictureHandlingOptions.Default
    objVAR.Settings.OCR.RetainLineNumbering = false
    objVAR.Settings.OCR.Rotation = RotationOptions.Auto
    objVAR.Settings.OCR.Languages.Add(LanguageOptions.English)
    
    ' PDF Compression
    objVAR.Settings.PDF.Compression.TextAndLineArt = false
    objVAR.Settings.PDF.Compression.ContentStream = ContentStreamOptions.Flate
    objVAR.Settings.PDF.Compression.EmbeddedFonts = false
    objVAR.Settings.PDF.Compression.BWImages = false
    objVAR.Settings.PDF.Compression.ColorAndGrayImages = false
    objVAR.Settings.PDF.Compression.MRC = MRCOptions.Disabled
    
    ' PDF Metadata
    objVAR.Settings.PDF.Metadata.Author = "John Doe"
    objVAR.Settings.PDF.Metadata.Title = "OCR Example"
    objVAR.Settings.PDF.Metadata.Subject = "Example"
    objVAR.Settings.PDF.Metadata.Keywords = "OCR, example, metadata"
    
    ' PDF Security
    objVAR.Settings.PDF.Security.UseSecurity = false
    objVAR.Settings.PDF.Security.Encryption = EncryptionType.AES_256
    objVAR.Settings.PDF.Security.OwnerPassword = "ownerPassword"
    objVAR.Settings.PDF.Security.UserPassword = "userPassword"
    objVAR.Settings.PDF.Security.CanAnnotate = false
    objVAR.Settings.PDF.Security.CanAssemble = false
    objVAR.Settings.PDF.Security.CanCopy = false
    objVAR.Settings.PDF.Security.CanEdit = false
    objVAR.Settings.PDF.Security.CanFillInFormFields = false
    objVAR.Settings.PDF.Security.CanMakeAccessible = false
    objVAR.Settings.PDF.Security.CanPrint = false
    objVAR.Settings.PDF.Security.CanPrintHiResolution = false
    
    ' PDF version
    objVAR.Settings.PDF.Version = PDFVersion.PDF1_5
    objVAR.Settings.PDF.Format = PDFOutputFormat.PDF
    objVAR.Settings.PDF.PDFACompliance = PDFAComplianceLevel.NotSet
    
    ' Basic Settings
    objVAR.Settings.Debug = true
    objVAR.Settings.Timeout = 30
    objVAR.Settings.PDF.Linearize = false
    objVAR.Settings.PDF.OverwriteMethod = OverwriteMethod.Always
    
    ' Start OCR conversion
    results = objVAR.Convert(strPath & "multipage.tif", strPath & "new.pdf")
    If results.OCRStatus <> OCRDK.Results.OCRStatus.Success Then
      ErrorHandler("Convert", results, results.OCRStatus.ToString())
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