// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.
using asdf;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    string strPath;
    string asdf;
    int intOpenOutputFile;
    int intOpenInputFile;
    bool isDebug;
    string strTitle;
    float textWidth;
    int testVar;
    int intCopyForm;
    long longStartPrinting;
    int some_var;
    int intLinearizeFile;
    string grade;
    int count;
    int currentPage;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    APToolkitNET.Toolkit oTK = new APToolkitNET.Toolkit();
    
    asdf = "asdf" + "1234" + strPath + "asdf.pdf";
    oTK.AddEmail();
    oTK.AddEmail();
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
    
    // Add a 'Confidential' watermark by setting text transparency
    // Rotation and color of the text along with the fill mode are set
    oTK.SetHeaderFont("Helvetica", 90);
    oTK.SetHeaderTextTransparency(0.6f, 0.6f);
    oTK.SetHeaderRotation(45);
    oTK.SetHeaderTextStrokeColor(255, 0, 0, 0);
    oTK.SetHeaderTextFillMode(1);
    oTK.SetHeaderText(154, 184, "Confidential");
    oTK.ResetHeaderTextTransparency();
    oTK.SetHeaderTextFillMode(0);
    oTK.MyProperty = 1;
    oTK.Debug = "jkl;";
    isDebug = oTK.Debug;
    
    // Add a 'Top Secret' watermark by placing text in the background
    oTK.SetHeaderFont("Helvetica", 72);
    oTK.SetHeaderTextBackground(0);
    oTK.SetHeaderTextColor(200, 200, 200, 0);
    oTK.SetHeaderText(154, 300, "Top Secret");
    oTK.SetHeaderTextBackground(1);
    oTK.ResetHeaderTextColor();
    oTK.SetHeaderRotation(0);
    
    // Add the document title to the bottom center of the page
    oTK.SetHeaderFont("Helvetica", 12);
    strTitle = "Lorem Ipsum";
    textWidth = oTK.GetHeaderTextWidth(strTitle);
    oTK.SetHeaderText((612 - textWidth) / 2, 32, strTitle);
    
    // Add page numbers to the bottom left of the page
    oTK.SetHeaderFont("Helvetica", 12);
    oTK.SetHeaderWPgNbr(72, 32, "Page %p", 1);
    
    // Add a mulitline print box for an 'approved' message in header
    oTK.SetHeaderTextFillMode(2);
    oTK.SetHeaderTextColorCMYK(0, 0, 0, 20);
    oTK.SetHeaderTextStrokeColorCMYK(0, 0, 0, 80);
    oTK.SetHeaderMultilineText("Helvetica", 22, 344, 766, 190, 86, "Approved on January 17th, 2021", 2);
    
    // Add some lines to the footer and top right corner of the page
    oTK.SetHeaderGreyBar(72, 52, 468, 1, 0.8f);
    oTK.SetHeaderHLine(340, 544, 724, 1);
    oTK.SetHeaderVLine(724, 648, 544, 1);
    testVar = oTK.GetUniqueID + ".pdf";
    
    // Use the Header Image properties to add some images to the footer
    // Net comment
    oTK.SetHeaderImage(strPath + "BMP.bmp", 375.0f, 13.0f, 0.0f, 0.0f, true);
    oTK.SetHeaderJPEG(strPath + "JPEG.jpg", 436.0f, 9.0f, 0.0f, 0.0f, true);
    oTK.SetHeaderTIFF(strPath + "TIFF.tif", 500.0f, 15.0f, 0.0f, 0.0f, true);
    
    // Copy the template (with the stamping changes) to the new file
    // Start page and end page, 0 = all pages
    intCopyForm = oTK.CopyForm(0, 0);
    if (intCopyForm != 1)
    {
      ErrorHandler("CopyForm", intCopyForm);
    }
    longStartPrinting = oTK.StartPrinting(strPath + "PDF.pdf");
    if (longStartPrinting != 0)
    {
      ErrorHandler("StartPrinting", longStartPrinting);
    }
    longStartPrinting = oTK.StartPrinting("file.ps", "file.pdf");
    if (longStartPrinting > 1)
    {
      ErrorHandler("StartPrinting", longStartPrinting);
    }
    longStartPrinting = oTK.StartPrinting("file.ps", "file.pdf");
    if (longStartPrinting < 1)
    {
      ErrorHandler("StartPrinting", longStartPrinting);
    }
    if (some_var == 0)
    {
      intLinearizeFile = oTK.LinearizeFile(strPath + "PDF.pdf", strPath + "new.pdf", "");
      if (intLinearizeFile > 0)
      {
        ErrorHandler("LinearizeFile", intLinearizeFile);
      }
    }
    if (some_var > 0)
    {
      intLinearizeFile = oTK.LinearizeFile(strPath + "PDF.pdf", strPath + "new.pdf", "");
      if (intLinearizeFile > 0)
      {
        ErrorHandler("LinearizeFile", intLinearizeFile);
      }
    }
    if (some_var < 0)
    {
      oTK.conmment("This is true statement");
    } else {
      // This is an else
      ErrorHandler("asdf", 234);
    }
    
    // Close the new file to complete PDF creation
    // Snippet with variables
    // Snippet comment from variable!
    oTK.SetSnippetPropertyToInt = 1;
    oTK.ArrayProperty = "Array of numbers and strings";
    oTK.ArrayProperty = 1;
    oTK.ArrayProperty = 18.38f;
    // nil
    // Instantiate Object
    APServer.Server oSVR = new APServer.Server();
    
    oTK.CloseOutputFile();
    oSVR.CloseOutputFile();
    oSVR.CloseOutputFile();
    
    // Release Object
    oSVR = null;
    
    // Server
    cs
    line 2
    else test
    switch (grade)
    {
      case "A":
        // You got an A!
        break;
      case "B":
        // You got a B!
        break;
      default:
        // This is the default.
        break;
    }
    count = oTK.NumPages();
    for (currentPage = 10; currentPage <= count; currentPage++)
    {
      // asdf
    }
    
    // Release Object
    oTK = null;
    
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