// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 

using System;

class Examples
{
  public static void Example()
  {
    int asdf;
    int some_var;
    string testVar;
    
    if (asdf == 0)
    {
      // If testVar is 0 then call stop printing
      .Whatever("input.pdf", 0, "output.pdf");
    }
    if (some_var < 0)
    {
      .conmment("This will execute if the if is true");
    } else {
      // This will execute if it's false
    }
    if (testVar == 0)
    {
      .StartPrinting = "123";
    }
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