// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF DocConverter 2015
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    // Instantiate Object
    APDocConverter.DocConverter oDC = new APDocConverter.DocConverter();
    
    // Release object: .NET = Yes, COM = Yes
    APDocConverter.FromPDFOptions oOne = new APDocConverter.FromPDFOptions();
    oOne.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect;
    oDC.SetFromPDFOptions(oOne);
    
    // Release Object
    oOne = null;
    
    // Release object: .NET = No, COM = Yes
    APDocConverter.FromPDFOptions oTwo = new APDocConverter.FromPDFOptions();
    oTwo.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect;
    oDC.SetFromPDFOptions(oTwo);
    
    // Release object: .NET = Yes, COM = Yes
    APDocConverter.FromPDFOptions oThree = new APDocConverter.FromPDFOptions();
    oThree.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect;
    oDC.SetFromPDFOptions(oThree);
    
    // Release Object
    oThree = null;
    
    // Release Object
    oDC = null;
    
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