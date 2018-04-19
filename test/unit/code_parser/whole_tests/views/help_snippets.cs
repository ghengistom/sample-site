// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 

using System;

class Examples
{
  public static void Example()
  {
    // Snippet with variables
    .SetSnippetPropertyToInt = 1;
    .ArrayProperty = "Array of numbers and strings";
    .ArrayProperty = 1;
    .ArrayProperty = 18.38f;
    // nil
    // Snippet with variables
    // Hello World!
    .SetSnippetPropertyToInt = 0;
    .ArrayProperty = "Array of strings and numbers";
    .ArrayProperty = 0;
    .ArrayProperty = 12.56f;
    // nil
    // Snippet with variables
    // Hello World!
    .SetSnippetPropertyToInt = 0;
    .ArrayProperty = "Array of strings and numbers";
    .ArrayProperty = 0;
    .ArrayProperty = 12.56f;
    // {"ps"=>["input.ps", "output.ps.pdf"], "xps"=>["input.xps", "output.xps.pdf"]}
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