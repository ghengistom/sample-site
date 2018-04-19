// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Toolkit 2016
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
    long longSetDocumentProperty;
    long longSetCustomProperty;
    long longSetUserProperty;
    int intCopyForm;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    // Instantiate Object
    APToolkitNET.Toolkit oTK = new APToolkitNET.Toolkit();
    
    // Create the new PDF file
    intOpenOutputFile = oTK.OpenOutputFile(strPath + "new.pdf");
    if (intOpenOutputFile != 0)
    {
      ErrorHandler("OpenOutputFile", intOpenOutputFile);
    }
    
    // Open the template PDF
    intOpenInputFile = oTK.OpenInputFile(strPath + "form.pdf");
    if (intOpenInputFile != 0)
    {
      ErrorHandler("OpenInputFile", intOpenInputFile);
    }
    
    // Get the reference to the XMP object
    APToolkitNET.XMPManager oXMP = oTK.GetXMPManager();
    
    // Set a document property
    longSetDocumentProperty = oXMP.SetDocumentProperty(APToolkitNET.XMPProperty.Author, "John Doe");
    if (longSetDocumentProperty != 0)
    {
      ErrorHandler("SetDocumentProperty", longSetDocumentProperty);
    }
    
    // Set a custom property
    longSetCustomProperty = oXMP.SetCustomProperty("example", "http://examples.activepdf.com");
    if (longSetCustomProperty != 0)
    {
      ErrorHandler("SetCustomProperty", longSetCustomProperty);
    }
    
    // Set the namespace for the user property
    oXMP.SetNamespace("dc", "http://purl.org/dc/elements/1.1/");
    
    // Set a user property
    longSetUserProperty = oXMP.SetUserProperty("contributor", "ActivePDF");
    if (longSetUserProperty != 0)
    {
      ErrorHandler("SetUserProperty", longSetUserProperty);
    }
    
    // Remove a property
    oXMP.RemoveDocumentProperty(APToolkitNET.XMPProperty.Author);
    
    // Get the reference to the InitialViewInfo object
    APToolkitNET.InitialViewInfo oIVI = oTK.GetInitialViewInfo();
    
    // Options for viewer window
    oIVI.CenterWindow = true;
    oIVI.FullScreen = false;
    oIVI.ResizeWindow = true;
    oIVI.Show = APToolkitNET.IVShow.IVShow_DocumentTitle;
    
    // Show or hide UI elements of the viewer
    oIVI.HideMenuBar = true;
    oIVI.HideToolBars = true;
    oIVI.HideWindowControls = true;
    oIVI.NavigationTab = APToolkitNET.IVNavigationTab.IVNavigationTab_PageOnly;
    
    // Page settings
    oIVI.Magnification = APToolkitNET.IVMagnification.IVMagnification_150;
    oIVI.OpenToPage = 2;
    oIVI.PageLayout = APToolkitNET.IVPageLayout.IVPageLayout_SinglePageContinuous;
    
    // Populate and flatten the fields, the data will remain in the place
    // of the field and the field data will be added to the XMP data
    oTK.SetFormFieldData("name", "John Doe", -997);
    oTK.SetFormFieldData("date", "1/1/2000", -997);
    oTK.SetFormFieldData("amount", "15.00", -997);
    
    // Copy the template (with any changes) to the new file
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