// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 

using System;

class Examples
{
  public static void Example()
  {
    int intStartPrinting;
    ServerDK.Results.ServerResult results;
    string strPath;
    long longBeginStartPrinting;
    XDK.Results.XtractorResult ManualResults;
    XDK.Results.TextResult ExtractedText;
    long longSetDocumentProperty;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    .MethodName("asdf", "#FF9900", 1, 2.0f, true);
    .AddEmail();
    intStartPrinting = .StartPrinting("file.ps", "file.pdf");
    if (intStartPrinting != 0)
    {
      ErrorHandler("StartPrinting", intStartPrinting);
    }
    intStartPrinting = .StartPrinting("file.ps", "file.pdf");
    if (intStartPrinting < 1)
    {
      ErrorHandler("StartPrinting", intStartPrinting);
    }
    intStartPrinting = .StartPrinting("file.ps", "file.pdf");
    if (intStartPrinting > 1)
    {
      ErrorHandler("StartPrinting", intStartPrinting);
    }
    results = .StartPrinting("file.ps", "file.pdf");
    if (results.ServerStatus != ServerDK.Results.ServerStatus.Success)
    {
      ErrorHandler("StartPrinting", results, results.ServerStatus.ToString());
    }
    results = .ClosePDF();
    if (results.ServerStatus != ServerDK.Results.ServerStatus.Success)
    {
      ErrorHandler("ClosePDF", results, results.ServerStatus.ToString());
    }
    longBeginStartPrinting = .BeginStartPrinting(strPath + "file.ps", strPath + "file.pdf");
    if (longBeginStartPrinting != 0)
    {
      ErrorHandler("BeginStartPrinting", longBeginStartPrinting);
    }
    longBeginStartPrinting = .BeginStartPrinting("file.ps", "file.pdf");
    if (longBeginStartPrinting < 1)
    {
      ErrorHandler("BeginStartPrinting", longBeginStartPrinting);
    }
    ErrorHandler("MethodName", VariableName);
    ManualResults = .OpenPDF(strPath + "Report.pdf");
    if (results.XtractorStatus != XDK.Results.XtractorStatus.Success)
    {
      ErrorHandler("OpenPDF", ManualResults, ManualResults.XtractorStatus.ToString());
    } else {
      ExtractedText = .GetTextByLocation(2, 100, 400, 200);
    }
    APToolkitNET.XMPManager oXMP = .GetXMPManager();
    // Set a document property
    longSetDocumentProperty = oXMP.SetDocumentProperty(NameSpace.XMPProperty.Author, "John Doe");
    if (longSetDocumentProperty != 0)
    {
      ErrorHandler("SetDocumentProperty", longSetDocumentProperty);
    }
    longSetDocumentProperty = oXMP.SetDocumentProperty(APToolkitNET.XMPProperty.Author, "John Doe");
    if (longSetDocumentProperty != 0)
    {
      ErrorHandler("SetDocumentProperty", longSetDocumentProperty);
    }
    longSetDocumentProperty = oXMP.SetDocumentProperty(NameSpace.XMPTest.Author, NameSpace.XMPTest.Title);
    if (longSetDocumentProperty != 0)
    {
      ErrorHandler("SetDocumentProperty", longSetDocumentProperty);
    }
    oXMP.RemoveDocumentProperty(NameSpace.XMPProperty.Author);
    
    // Release Object
    oXMP = null;
    Product.Class oReleaseOne = .MethodObject();
    
    // Release Object
    oReleaseOne = null;
    Product.Class oReleaseTwo = .MethodObject();
    
    // Release Object
    oReleaseTwo = null;
    Product.Class oNoRelease = .MethodObject();
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