// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF CADConverter 2015
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    string cadXML;
    string strPath;
    DCDK.Results.DocConverterResult results;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    APDocConverter.DocConverter oDC = new APDocConverter.DocConverter();
    
    // Settings specific to CAD conversions
    APDocConverter.CADConverter.CADConverter oCAD = new APDocConverter.CADConverter.CADConverter();
    
    // Options available for CAD conversions
    // Options that are 'NotSet' use the setting from the configuation manager
    oCAD.ASCIIHexEncoding = false;
    oCAD.Color = APDocConverter.CADConverter.ColorMode.NotSet;
    oCAD.EmbedFonts = APDocConverter.CADConverter.EmbedFontsOptions.NotSet;
    oCAD.ExportLayers = APDocConverter.CADConverter.LayersOptions.NotSet;
    oCAD.ExportLayouts = APDocConverter.CADConverter.LayoutsOptions.NotSet;
    oCAD.FlateCompression = false;
    oCAD.HatchToBitmapDPI = 150;
    oCAD.HiddenLineRemoval = false;
    oCAD.Lineweight = APDocConverter.CADConverter.LineweightOptions.NotSet;
    oCAD.OtherHatchesSettings = APDocConverter.CADConverter.OtherHatchOptions.NotSet;
    oCAD.PlotStyleTableName = "";
    oCAD.SHXTextAsGeometry = false;
    oCAD.SimpleGeometryOptimization = false;
    oCAD.SolidHatchesSettings = APDocConverter.CADConverter.SolidHatchOptions.NotSet;
    oCAD.TrueTypeAsGeometry = false;
    oCAD.ZoomToExtents = true;
    
    // Page size is only set if ZoomToExtents is true
    oCAD.SetExtentsPageSize(210, 297);
    
    // Convert the settings to XML and send it to DocConverter
    cadXML = oCAD.Serialize();
    oDC.SetAddonOptions(cadXML);
    
    // Release Object
    oCAD = null;
    
    // Convert the file to PDF
    // If the output parameter is not used the created PDF will use
    // the input string substituting the filename extension to 'pdf'
    results = oDC.ConvertToPDF(strPath + "sample.dwg", strPath + "new.pdf");
    if (results.DocConverterStatus != DCDK.Results.DocConverterStatus.Success)
    {
      ErrorHandler("ConvertToPDF", results, results.DocConverterStatus.ToString());
    }
    
    // Release Object
    oDC = null;
    
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