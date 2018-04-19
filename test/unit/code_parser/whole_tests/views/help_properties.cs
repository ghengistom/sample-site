// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 

using System;

class Examples
{
  public static void Example()
  {
    bool isDebug;
    int testVar;
    
    .Debug = "asdf";
    .Debug = 4;
    .Debug = true;
    .Debug = false;
    .Debug = asdf;
    .Debug = 0;
    .Show = NameSpace.IVShow.IVShow_DocumentTitle;
    .EngineToUse = APWebGrabberInterface.ConversionEngine.IE;
    isDebug = .Debug;
    testVar = .GetUniqueID + ".pdf";
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