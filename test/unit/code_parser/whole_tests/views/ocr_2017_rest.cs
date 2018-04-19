// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF OCR 2017
// Example generated 01/01/2000 

using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

class Examples
{
  public static void Example()
  {
    Task.Run(async () =>
    {
        string Folder = AppDomain.CurrentDomain.BaseDirectory;
        string Result = string.Empty;
        string InputFile = Folder + "multipage.tif";
        string OutputFile = Folder + "new.pdf";
    
        using (HttpClient client = new HttpClient())
        {
            string token = string.Empty;
    
            Uri uri = new Uri("http://localhost:62625/api/OCR/Conversion");
    
            // Set the Access Token for authorization
            token = "<<insert token here>>";
            AuthenticationHeaderValue ahv = new AuthenticationHeaderValue("Bearer", token);
            client.DefaultRequestHeaders.Authorization = ahv;
    
            // Multipart form post
            MultipartFormDataContent content = new MultipartFormDataContent();
    
            // Input file as a file stream
            FileStream fs = File.OpenRead(InputFile);
            StreamContent streamContent = new StreamContent(fs);
            streamContent.Headers.Add("Content-Type", "application/octet-stream");
            streamContent.Headers.Add("Content-Disposition", @"form-data; name=""InputFile""; filename=""" + Path.GetFileName(InputFile) + @"""");
            content.Add(streamContent, InputFile, Path.GetFileName(InputFile));
    
            // Each setting can be passed in here as a new StringContent
            content.Add(new StringContent("0"), "OCRType");
            content.Add(new StringContent("1"), "PictureHandling");
            content.Add(new StringContent("4"), "PDFVersion");
            content.Add(new StringContent("1"), "Linearize");
    
            // Post the content to the endpoint (uri)
            HttpResponseMessage hrm = await client.PostAsync(uri, content);
            if (hrm.StatusCode == HttpStatusCode.OK)
            {
                // Get the resulting output of the post
                byte[] bytes = await hrm.Content.ReadAsByteArrayAsync();
                // Specify where you want the PDF to save
                File.WriteAllBytes(OutputFile, bytes);
            }
            else
            {
                // Get the error message if something went wrong
                string error = await hrm.Content.ReadAsStringAsync();
                WriteResults(error);
            }
        }
    }).Wait();
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