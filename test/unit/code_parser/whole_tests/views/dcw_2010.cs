// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF DocConverter WBE 2010
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    string strPath;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    activePDF.API.DocConverterWBE.DocConverter oDCw = new activePDF.API.DocConverterWBE.DocConverter();
    
    IResult irSuccess = new Result(Code.Success, "ConvertToPDF");
    IResult intConvertToPDF = oDCw.ConvertToPDF(strPath + "word.doc", strPath + "word.pdf");
    if (intConvertToPDF.Status != irSuccess.Status)
    {
    ErrorHandler("ConvertToPDF", intConvertToPDF.Status + " - " + intConvertToPDF.Details);
    }
    
    // Release Object
    oDCw = null;
    
    // Process Complete
    WriteResults("Done!");
  }
  
  // Error Handling
  public static void ErrorHandler(string strMethod, object rtnCode)
  {
    WriteResults(strMethod + " error:  " + rtnCode.ToString());
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