// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Server 2009
// Example generated 01/01/2000 

using System;

class Examples
{
  public static void Example()
  {
    string strVariable;
    string strText;
    int y;
    short shortVariable;
    long longVariable;
    float floatVariable;
    bool boolVariable;
    byte[] byteVariable;
    Array arrayNames;
    string[] arrayFiles;
    string strPath;
    string[] arrayFiles2;
    float[] arrayFloats;
    PointF[] arrayPoints;
    XDK.Results.TextResult ExtractedText;
    string strURL;
    string text;
    int AddBookmarksOutput;
    
    strPath = System.AppDomain.CurrentDomain.BaseDirectory;

    strText = "asdf asdf";
    y = 10;
    shortVariable = 30000;
    longVariable = 100000;
    floatVariable = 46.72f;
    boolVariable = true;
    arrayNames = new string[] {"James", "John"};
    arrayFiles = new string[] {"asdf.pdf", "asdf1.pdf"};
    arrayFiles2 = new string[] {strPath + "cover.pdf", "5pageLI.pdf", "6pageAA.pdf"};
    arrayFloats = new float[] {4.2f, 6.7f, 1.3f, 9.3f};
    arrayPoints = new PointF[] {new PointF(210.0f, 776.0f), new PointF(246.0f, 776.0f), new PointF(210.0f, 740.0f), new PointF(246.0f, 740.0f)};
    .Debug = boolVariable;
    .AddURLBookmark("activePDF.com", strURL);
    text = "asdf" + "1235" + strPath + "asdf.pdf";
    AddBookmarksOutput = .AddBookmarks("asdf", 0, "some_page");
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