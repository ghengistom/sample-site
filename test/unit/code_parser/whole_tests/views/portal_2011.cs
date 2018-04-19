// Copyright (c) 2000 ActivePDF, Inc.
// ActivePDF Portal 2011
// Example generated 01/01/2000 

using System;
using System.Diagnostics;
using System.IO;

partial class Example : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    	if (!IsPostBack)
    	{
    		// Specify the document to open with portal
    		this.PdfWebControl1.CreateDocument("filename", System.IO.File.ReadAllBytes(Server.MapPath(@"portal.pdf")));
    	}
    }
    
    protected void SaveComplete(object sender, SaveCompleteEventArgs e)
    {
    	// Check the SaveType to determine action to perform
    	switch (e.SaveType)
    	{
    		// Save the file to disk when saving or downloading
    		case SaveType.Save:
    		case SaveType.Download:
    
    			break;
    
    		// Ignore all other save types
    		default:
    
    			break;
    	}
    }
  
}