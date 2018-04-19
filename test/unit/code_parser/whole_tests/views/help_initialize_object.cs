// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 

using System;

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

// Make sure to add the ActivePDF product .NET DLL(s) to your application.
// .NET DLL(s) are typically found in the products 'bin' folder.

class Examples
{
  public static void Example()
  {
    int intDoPrint;
    string strPath;
    int intOpenInputFile;
    string strFieldInfo;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    NameSpace.Class objVAR = new NameSpace.Class();
    
    
    // Release Object
    objVAR = null;
    
    // Instantiate Object
    APDocConv.APDocConverter oDC = new APDocConv.APDocConverter();
    
    
    // Release Object
    oDC = null;
    
    // Instantiate Object
    activePDF.API.DocConverterWBE.DocConverter oDCw = new activePDF.API.DocConverterWBE.DocConverter();
    
    
    // Release Object
    oDCw = null;
    
    // Instantiate Object
    APMeridian.Meridian oMER = new APMeridian.Meridian();
    
    
    // Release Object
    oMER = null;
    
    // Instantiate Object
    APServer.Server oSVR = new APServer.Server();
    
    
    // Release Object
    oSVR = null;
    
    // Instantiate Object
    APToolkitNET.Toolkit oTK = new APToolkitNET.Toolkit();
    
    
    // Release Object
    oTK = null;
    
    // Instantiate Object
    APWebGrbNET.APWebGrabber oWG = new APWebGrbNET.APWebGrabber();
    
    
    // Release Object
    oWG = null;
    
    // Instantiate Object
    APXtractor.Xtractor oXT = new APXtractor.Xtractor();
    
    
    // Release Object
    oXT = null;
    
    .with.();
    .with.toolkit();
    // Instantiate Object
    APWebGrbNET.APWebGrabber oWG = new APWebGrbNET.APWebGrabber();
    
    intDoPrint = oWG.DoPrint("127.0.0.1", 54545);
    if (intDoPrint != 0)
    {
      ErrorHandler("DoPrint", intDoPrint);
    }
    // Instantiate Object
    APToolkitNET.Toolkit oTK = new APToolkitNET.Toolkit();
    
    intOpenInputFile = oTK.OpenInputFile(strPath + "new.pdf");
    if (intOpenInputFile != 0)
    {
      ErrorHandler("OpenInputFile", intOpenInputFile);
    }
    oWG.Function("asdf");
    
    // Release Object
    oTK = null;
    
    
    // Release Object
    oWG = null;
    
    // Instantiate Object
    APDocConv.APDocConverter oDC = new APDocConv.APDocConverter();
    
    APDocConverter.FromPDFOptions fPDF = new APDocConverter.FromPDFOptions();
    fPDF.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect;
    oDC.SetFromPDFOptions(fPDF);
    
    // Release Object
    fPDF = null;
    
    // Release Object
    oDC = null;
    
    APDocConverter.FromPDFOptions fPDF = new APDocConverter.FromPDFOptions();
    fPDF.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect;
    // Instantiate Object
    APDocConv.APDocConverter oDC = new APDocConv.APDocConverter();
    
    // Snippet with variables
    oDC.SetSnippetPropertyToInt = 1;
    oDC.ArrayProperty = "Array of numbers and strings";
    oDC.ArrayProperty = 1;
    oDC.ArrayProperty = 18.38f;
    // nil
    
    // Release Object
    oDC = null;
    
    APDocConverter.FromPDFOptions fPDF = new APDocConverter.FromPDFOptions();
    fPDF.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect;
    oDC.SetFromPDFOptions(fPDF);
    
    // Release Object
    fPDF = null;
    APToolkitNET.XMPManager oXMP = .GetXmpManager();
    oXMP.AddFieldsToXMP = 1;
    APToolkitNET.XMPFieldInfo oXMPField = oXMP.GetXMPFieldInfo("name");
    strFieldInfo = oXMPField.Name;
    
    // Release Object
    oXMPField = null;
    
    // Release Object
    oXMP = null;
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