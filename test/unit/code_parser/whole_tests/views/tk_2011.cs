// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Toolkit 2011
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    string strPath;
    int intOpenOutputFile;
    int intOpenInputFile;
    int intCopyForm;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    APToolkitNET.Toolkit oTK = new APToolkitNET.Toolkit();
    
    // Here you can place any code that will alter the output file
    // Such as adding security, setting page dimensions, etc.
    
    // Create the new PDF file
    intOpenOutputFile = oTK.OpenOutputFile(strPath + "new.pdf");
    if (intOpenOutputFile != 0)
    {
      ErrorHandler("OpenOutputFile", intOpenOutputFile);
    }
    
    // Open the template PDF
    intOpenInputFile = oTK.OpenInputFile(strPath + "PDF.pdf");
    if (intOpenInputFile != 0)
    {
      ErrorHandler("OpenInputFile", intOpenInputFile);
    }
    
    // Here you can call any Toolkit functions that will manipulate
    // the input file such as text and image stamping, form filling, etc.
    
    // Copy the template (with any changes) to the new file
    // Start page and end page, 0 = all pages
    intCopyForm = oTK.CopyForm(0, 0);
    if (intCopyForm != 1)
    {
      ErrorHandler("CopyForm", intCopyForm);
    }
    
    // Close the new file to complete PDF creation
    oTK.CloseOutputFile();
    
    // Release Object
    oTK.Dispose();
    
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