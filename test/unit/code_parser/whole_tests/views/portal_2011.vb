' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Portal 2011
' Example generated 01/01/2000 

Imports System.IO

Partial Class Example
  Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    
    	If Not IsPostBack Then
    
    		' Specify the document to open with portal
    		Me.PdfWebControl1.CreateDocument("filename", System.IO.File.ReadAllBytes(Server.MapPath("portal.pdf")))
    
    	End If
    End Sub
    
    Protected Sub SaveComplete(ByVal sender As Object, ByVal e As SaveCompleteEventArgs)
    
    	' Check the SaveType to determine action to perform
    	Select Case e.SaveType
    
    		' Save the file to disk when saving or downloading
    		Case SaveType.Save, SaveType.Download
    
    			Exit Select
    
    		' Ignore all other save types
    		Case Else
    
    			Exit Select
    	End Select
    End Sub
  
End Class