' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Toolkit 2016
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim strPath As String, intOpenOutputFile As Integer, intOpenInputFile As Integer, intSetDocumentProperty As Integer, _
      intSetCustomProperty As Integer, intSetUserProperty As Integer, intCopyForm As Integer

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim oTK As APToolkitNET.Toolkit = New APToolkitNET.Toolkit()
    
    ' Create the new PDF file
    intOpenOutputFile = oTK.OpenOutputFile(strPath & "new.pdf")
    If intOpenOutputFile <> 0 Then
      ErrorHandler("OpenOutputFile", intOpenOutputFile)
    End If
    
    ' Open the template PDF
    intOpenInputFile = oTK.OpenInputFile(strPath & "form.pdf")
    If intOpenInputFile <> 0 Then
      ErrorHandler("OpenInputFile", intOpenInputFile)
    End If
    
    ' Get the reference to the XMP object
    Dim oXMP As APToolkitNET.XMPManager = oTK.GetXMPManager()
    
    ' Set a document property
    intSetDocumentProperty = oXMP.SetDocumentProperty(APToolkitNET.XMPProperty.Author, "John Doe")
    If intSetDocumentProperty <> 0 Then
      ErrorHandler("SetDocumentProperty", intSetDocumentProperty)
    End If
    
    ' Set a custom property
    intSetCustomProperty = oXMP.SetCustomProperty("example", "http://examples.activepdf.com")
    If intSetCustomProperty <> 0 Then
      ErrorHandler("SetCustomProperty", intSetCustomProperty)
    End If
    
    ' Set the namespace for the user property
    oXMP.SetNamespace("dc", "http://purl.org/dc/elements/1.1/")
    
    ' Set a user property
    intSetUserProperty = oXMP.SetUserProperty("contributor", "ActivePDF")
    If intSetUserProperty <> 0 Then
      ErrorHandler("SetUserProperty", intSetUserProperty)
    End If
    
    ' Remove a property
    oXMP.RemoveDocumentProperty(APToolkitNET.XMPProperty.Author)
    
    ' Get the reference to the InitialViewInfo object
    Dim oIVI As APToolkitNET.InitialViewInfo = oTK.GetInitialViewInfo()
    
    ' Options for viewer window
    oIVI.CenterWindow = true
    oIVI.FullScreen = false
    oIVI.ResizeWindow = true
    oIVI.Show = APToolkitNET.IVShow.IVShow_DocumentTitle
    
    ' Show or hide UI elements of the viewer
    oIVI.HideMenuBar = true
    oIVI.HideToolBars = true
    oIVI.HideWindowControls = true
    oIVI.NavigationTab = APToolkitNET.IVNavigationTab.IVNavigationTab_PageOnly
    
    ' Page settings
    oIVI.Magnification = APToolkitNET.IVMagnification.IVMagnification_150
    oIVI.OpenToPage = 2
    oIVI.PageLayout = APToolkitNET.IVPageLayout.IVPageLayout_SinglePageContinuous
    
    ' Populate and flatten the fields, the data will remain in the place
    ' of the field and the field data will be added to the XMP data
    oTK.SetFormFieldData("name", "John Doe", -997)
    oTK.SetFormFieldData("date", "1/1/2000", -997)
    oTK.SetFormFieldData("amount", "15.00", -997)
    
    ' Copy the template (with any changes) to the new file
    intCopyForm = oTK.CopyForm(0, 0)
    If intCopyForm <> 1 Then
      ErrorHandler("CopyForm", intCopyForm)
    End If
    
    ' Close the new file to complete PDF creation
    oTK.CloseOutputFile()
    
    ' Release Object
    oTK.Dispose()
    
    ' Process Complete
    WriteResults("Done!")
  End Sub
  
  ' Error Handling
  ' Error messages written to debug output
  Sub ErrorHandler(ByVal strMethod, ByVal RtnCode)
    WriteResults(strMethod + " error:  " + rtnCode.ToString())
  End Sub
  
  ' Write output data
  Sub WriteResults(content As String)
    ' Choose where to write out results
  
    ' Debug output
    'System.Diagnostics.Debug.WriteLine("ActivePDF: * " + content)
  
    ' Console
    Console.WriteLine(content)
  
    ' Log file
    'Using tw = New System.IO.StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "application.log", True)
    '   tw.WriteLine("[" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "]: => " + content)
    'End Using
  End Sub
End Class