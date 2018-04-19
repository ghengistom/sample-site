// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Rasterizer 2017
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    string strPath;
    int pageCount;
    int currentPage;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    NameSpace.Class objVAR = new NameSpace.Class();
    
    // Open PDF
    objVAR.OpenFile(strPath + "doc.pdf");
    
    // Get page count of open file
    pageCount = objVAR.NumPages();
    
    for (currentPage = 1; currentPage <= pageCount; currentPage++)
    {
      // Image Format
      objVAR.ImageFormat = NameSpace.ImageType.ImgJPEG;
      
      // Output Type
      objVAR.OutputFormat = NameSpace.OutputFormatType.OutFile;
      
      // Other settings
      objVAR.OutputFileName = strPath + "doc" + currentPage + ".jpg";
      objVAR.JPEGQuality = 72;
      objVAR.IncludeAnnotations = true;
      
      // Render the current page
      objVAR.RenderPage(currentPage);
    }
    
    // Finished rendering pages, close file
    objVAR.CloseFile();
    
    // Release Object
    objVAR.Dispose();
    
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