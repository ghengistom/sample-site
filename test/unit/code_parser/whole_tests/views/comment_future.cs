// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Toolkit Professional 2012
// Example generated 01/01/2000 (beta)

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    // Instantiate Object
    APToolkitNET.Toolkit oTK = new APToolkitNET.Toolkit();
    
    // asdf
    
    // Release Object
    oTK = null;
    
    // Process Complete
    WriteResults("Done!");
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