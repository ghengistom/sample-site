// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF DocConverter 2014
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    string strPath;
    DCDK.Results.DocConverterResult results;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    APDocConverter.DocConverter oDC = new APDocConverter.DocConverter();
    
    results = oDC.ConvertToPDF(strPath + "word.doc", strPath + "word.pdf");
    if (results.DocConverterStatus != DCDK.Results.DocConverterStatus.Success)
    {
      ErrorHandler("ConvertToPDF", results, results.DocConverterStatus.ToString());
    }
    
    results = oDC.ConvertFromPDF(strPath + "word.pdf", strPath + "word.pdf", oDC.FromPDFFormat = APDocConverter.FromPDFFunction.ToWord);
    if (results.DocConverterStatus != DCDK.Results.DocConverterStatus.Success)
    {
      ErrorHandler("ConvertFromPDF", results, results.DocConverterStatus.ToString());
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