// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Spooler 2017
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    Array arrayAvailableDPIs;
    Array arrayBinSources;
    bool isCollate;
    APSpoolerNET.ColorMode valColorMode;
    int valDPI;
    APSpoolerNET.DuplexMode valDuplex;
    Array arrayFormNames;
    APSpoolerNET.Orientation valOrientation;
    Array arrayPaperSizes;
    string valPrinterName;
    APSpoolerNET.TrueTypeOptions valTrueType;
    string strPath;
    SpoolerDK.Results.SpoolerResult results;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    NameSpace.Class objVAR = new NameSpace.Class();
    
    // Use the PrinterInfo object to retrieve current settings
    // and available options for the specified printer.
    APSpoolerNET.PrinterInfo oPI = objVAR.PrinterInfo("Microsoft Print to PDF");
    
    arrayAvailableDPIs = oPI.AvailableDPI;
    arrayBinSources = oPI.BinSources;
    isCollate = oPI.Collate;
    valColorMode = oPI.ColorMode;
    valDPI = oPI.DPI;
    valDuplex = oPI.Duplex;
    arrayFormNames = oPI.FormNames;
    valOrientation = oPI.Orientation;
    arrayPaperSizes = oPI.PaperSizes;
    valPrinterName = oPI.PrinterName;
    valTrueType = oPI.TrueTypeOption;
    
    // Use the PrintJobProfile object to set specific printer settings
    // for the print job if the default options are not what is needed.
    APSpoolerNET.PrinterProfile oPJP = objVAR.PrintJobProfile("SettingsOne");
    
    oPJP.BinSource = 15;
    oPJP.Collate = false;
    oPJP.ColorMode = NameSpace.ColorMode.Color;
    oPJP.DPI = 300;
    oPJP.Duplex = NameSpace.DuplexMode.Simplex;
    oPJP.FormName = "SampleForm";
    oPJP.Nup = 0;
    oPJP.Orientation = NameSpace.Orientation.Portrait;
    oPJP.PaperSize = NameSpace.PaperSize.Letter;
    oPJP.PrinterName = "Microsoft Print to PDF";
    oPJP.PrintOddEvenAll = NameSpace.PrintPages.AllPages;
    oPJP.ProfileName = "SettingsOne";
    oPJP.Scaling = NameSpace.PrintScaling.Custom;
    oPJP.CustomScaling = 95.0f;
    oPJP.TrueTypeOption = NameSpace.TrueTypeOptions.Substitute;
    
    // File specific settings
    objVAR.Copies = 1;
    objVAR.PageRange = "1-2,4";
    objVAR.PrintAnnotations = true;
    
    // Print a PDF
    results = objVAR.PrintFile(oPJP, strPath + "5pageLI.pdf");
    if (results.SpoolerStatus != SpoolerDK.Results.SpoolerStatus.Success)
    {
      ErrorHandler("PrintFile", results, results.SpoolerStatus.ToString());
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