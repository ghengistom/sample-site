// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF OCR 2017
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.
using OCRData.Enums.ImageProcessing;
using OCRData.Enums.OCR;
using OCRData.Enums.PDF;
using ConverterKit.DK.Enums.PDF;

class Examples
{
  public static void Example()
  {
    string strPath;
    OCRDK.Results.OCRResult results;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    NameSpace.Class objVAR = new NameSpace.Class();
    
    // OCR Settings
    objVAR.Settings.OCR.Deskew = DeskewOptions.Auto2D;
    objVAR.Settings.OCR.Despeckled = true;
    objVAR.Settings.OCR.ExportBookmarks = false;
    objVAR.Settings.OCR.OCRType = OCRTypeOptions.SearchablePDF;
    objVAR.Settings.OCR.PictureHandling = PictureHandlingOptions.Default;
    objVAR.Settings.OCR.RetainLineNumbering = false;
    objVAR.Settings.OCR.Rotation = RotationOptions.Auto;
    objVAR.Settings.OCR.Languages.Add(LanguageOptions.English);
    
    // PDF Compression
    objVAR.Settings.PDF.Compression.TextAndLineArt = false;
    objVAR.Settings.PDF.Compression.ContentStream = ContentStreamOptions.Flate;
    objVAR.Settings.PDF.Compression.EmbeddedFonts = false;
    objVAR.Settings.PDF.Compression.BWImages = false;
    objVAR.Settings.PDF.Compression.ColorAndGrayImages = false;
    objVAR.Settings.PDF.Compression.MRC = MRCOptions.Disabled;
    
    // PDF Metadata
    objVAR.Settings.PDF.Metadata.Author = "John Doe";
    objVAR.Settings.PDF.Metadata.Title = "OCR Example";
    objVAR.Settings.PDF.Metadata.Subject = "Example";
    objVAR.Settings.PDF.Metadata.Keywords = "OCR, example, metadata";
    
    // PDF Security
    objVAR.Settings.PDF.Security.UseSecurity = false;
    objVAR.Settings.PDF.Security.Encryption = EncryptionType.AES_256;
    objVAR.Settings.PDF.Security.OwnerPassword = "ownerPassword";
    objVAR.Settings.PDF.Security.UserPassword = "userPassword";
    objVAR.Settings.PDF.Security.CanAnnotate = false;
    objVAR.Settings.PDF.Security.CanAssemble = false;
    objVAR.Settings.PDF.Security.CanCopy = false;
    objVAR.Settings.PDF.Security.CanEdit = false;
    objVAR.Settings.PDF.Security.CanFillInFormFields = false;
    objVAR.Settings.PDF.Security.CanMakeAccessible = false;
    objVAR.Settings.PDF.Security.CanPrint = false;
    objVAR.Settings.PDF.Security.CanPrintHiResolution = false;
    
    // PDF version
    objVAR.Settings.PDF.Version = PDFVersion.PDF1_5;
    objVAR.Settings.PDF.Format = PDFOutputFormat.PDF;
    objVAR.Settings.PDF.PDFACompliance = PDFAComplianceLevel.NotSet;
    
    // Basic Settings
    objVAR.Settings.Debug = true;
    objVAR.Settings.Timeout = 30;
    objVAR.Settings.PDF.Linearize = false;
    objVAR.Settings.PDF.OverwriteMethod = OverwriteMethod.Always;
    
    // Start OCR conversion
    results = objVAR.Convert(strPath + "multipage.tif", strPath + "new.pdf");
    if (results.OCRStatus != OCRDK.Results.OCRStatus.Success)
    {
      ErrorHandler("Convert", results, results.OCRStatus.ToString());
    }
    
    // Release Object
    objVAR = null;
    
    // Process Complete
    WriteResults("Done!");
  }
  
  // Error Handling
  public static void ErrorHandler(string strMethod, ADK.Results.Result results, string errorStatus)
  {
    WriteResults("Error with " + strMethod);
    WriteResults(errorStatus);
    WriteResults(results.Details);
    if (results.Origin.Function != strMethod)
    {
      WriteResults(results.Origin.Class + "." + results.Origin.Function);
    }
    if (results.ResultException != null)
    {
      // To view the stack trace on an exception uncomment the line below
      //WriteResults(results.ResultException.StackTrace);
    }
    Environment.Exit(1);
  }
  
  // Write output data
  public static void WriteResults(string content)
  {
    // Choose where to write out results
  
    // Debug output
    //System.Diagnostics.Debug.WriteLine("ActivePDF: * " + content);
  
    // Console
    Console.WriteLine(content);
  
    // Log file
    //using (System.IO.TextWriter writer = new System.IO.StreamWriter(System.AppDomain.CurrentDomain.BaseDirectory + "application.log", true))
    //{
    //    writer.WriteLine("[" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "]: => " + content);
    //}
  }
}