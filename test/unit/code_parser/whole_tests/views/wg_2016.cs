// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF WebGrabber 2016
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    string strPath;
    WebGrabberDK.Results.WebGrabberResult results;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    APWebGrabber.WebGrabber oWG = new APWebGrabber.WebGrabber();
    
    // C:\ProgramData\activePDF\Logs\
    oWG.Debug = true;
    
    oWG.LinearizePDF = true;
    
    // Set the amount of time before a request will time out
    oWG.TimeoutSpan = new TimeSpan(0, 0, 40);
    
    // Margins (Top, Bottom, Left, Right) 1.0 = 1"
    oWG.SetMargins(0.75f, 0.75f, 0.75f, 0.75f);
    
    // 0 = Portrait, 1 = Landscape
    oWG.Orientation = 0;
    
    // Rendering engine used for the HTML
    oWG.EngineToUse = APWebGrabberInterface.ConversionEngine.IE;
    
    // Convert the HTML background (IE engine only)
    oWG.PrintBackground = true;
    
    // PDF output location and filename
    oWG.OutputDirectory = strPath;
    oWG.NewDocumentName = "basic.pdf";
    
    // HTML to convert
    // Examples:
    // http://domain.com/path/file.aspx
    // c:\folder\file.html
    oWG.URL = "http://examples.activepdf.com/samples/doc";
    
    // Perform the HTML to PDF conversion
    results = oWG.ConvertToPDF();
    if (results.WebGrabberStatus != WebGrabberDK.Results.WebGrabberStatus.Success)
    {
      ErrorHandler("ConvertToPDF", results, results.WebGrabberStatus.ToString());
    }
    
    // Release Object
    oWG = null;
    
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