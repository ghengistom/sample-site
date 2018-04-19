// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF WebGrabber Enterprise 2009
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    int intDoPrint;
    
    // Instantiate Object
    APWebGrbNET.APWebGrabber oWG = new APWebGrbNET.APWebGrabber();
    
    // Perform the HTML to PDF conversion
    intDoPrint = oWG.DoPrint("127.0.0.1", 54545);
    if (intDoPrint != 0)
    {
      ErrorHandler("DoPrint", intDoPrint);
    }
    
    // Cleans up all internal string variables used during conversion
    // By default variables are deleted 3 minutes after the conversion
    oWG.CleanUp("127.0.0.1", 54545);
    
    // Release Object
    oWG = null;
    
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