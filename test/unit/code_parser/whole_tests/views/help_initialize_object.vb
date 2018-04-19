' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    Dim intDoPrint As Integer, strPath As String, intOpenInputFile As Integer, strFieldInfo As String

    strPath = AppDomain.CurrentDomain.BaseDirectory

    ' Instantiate Object
    Dim objVAR As NameSpace.Class = New NameSpace.Class()
    
    
    ' Release Object
    objVAR = Nothing
    
    ' Instantiate Object
    Dim oDC As APDocConv.APDocConverter = New APDocConv.APDocConverter()
    
    
    ' Release Object
    oDC = Nothing
    
    ' Instantiate Object
    Dim oDCw As activePDF.API.DocConverterWBE.DocConverter = New activePDF.API.DocConverterWBE.DocConverter()
    
    
    ' Release Object
    oDCw = Nothing
    
    ' Instantiate Object
    Dim oMER As APMeridian.Meridian = New APMeridian.Meridian()
    
    
    ' Release Object
    oMER = Nothing
    
    ' Instantiate Object
    Dim oSVR As APServer.Server = New APServer.Server()
    
    
    ' Release Object
    oSVR = Nothing
    
    ' Instantiate Object
    Dim oTK As APToolkitNET.Toolkit = New APToolkitNET.Toolkit()
    
    
    ' Release Object
    oTK = Nothing
    
    ' Instantiate Object
    Dim oWG As APWebGrbNET.APWebGrabber = New APWebGrbNET.APWebGrabber()
    
    
    ' Release Object
    oWG = Nothing
    
    ' Instantiate Object
    Dim oXT As APXtractor.Xtractor = New APXtractor.Xtractor()
    
    
    ' Release Object
    oXT = Nothing
    
    .with.()
    .with.toolkit()
    ' Instantiate Object
    Dim oWG As APWebGrbNET.APWebGrabber = New APWebGrbNET.APWebGrabber()
    
    intDoPrint = oWG.DoPrint("127.0.0.1", 54545)
    If intDoPrint <> 0 Then
      ErrorHandler("DoPrint", intDoPrint)
    End If
    ' Instantiate Object
    Dim oTK As APToolkitNET.Toolkit = New APToolkitNET.Toolkit()
    
    intOpenInputFile = oTK.OpenInputFile(strPath & "new.pdf")
    If intOpenInputFile <> 0 Then
      ErrorHandler("OpenInputFile", intOpenInputFile)
    End If
    oWG.Function("asdf")
    
    ' Release Object
    oTK = Nothing
    
    
    ' Release Object
    oWG = Nothing
    
    ' Instantiate Object
    Dim oDC As APDocConv.APDocConverter = New APDocConv.APDocConverter()
    
    Dim fPDF As APDocConverter.FromPDFOptions = New APDocConverter.FromPDFOptions()
    fPDF.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect
    oDC.SetFromPDFOptions(fPDF)
    
    ' Release Object
    fPDF = Nothing
    
    ' Release Object
    oDC = Nothing
    
    Dim fPDF As APDocConverter.FromPDFOptions = New APDocConverter.FromPDFOptions()
    fPDF.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect
    ' Instantiate Object
    Dim oDC As APDocConv.APDocConverter = New APDocConv.APDocConverter()
    
    ' Snippet with variables
    oDC.SetSnippetPropertyToInt = 1
    oDC.ArrayProperty = "Array of numbers and strings"
    oDC.ArrayProperty = 1
    oDC.ArrayProperty = 18.38
    ' nil
    
    ' Release Object
    oDC = Nothing
    
    Dim fPDF As APDocConverter.FromPDFOptions = New APDocConverter.FromPDFOptions()
    fPDF.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect
    oDC.SetFromPDFOptions(fPDF)
    
    ' Release Object
    fPDF = Nothing
    Dim oXMP As APToolkitNET.XMPManager = .GetXmpManager()
    oXMP.AddFieldsToXMP = 1
    Dim oXMPField As APToolkitNET.XMPFieldInfo = oXMP.GetXMPFieldInfo("name")
    strFieldInfo = oXMPField.Name
    
    ' Release Object
    oXMPField = Nothing
    
    ' Release Object
    oXMP = Nothing
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