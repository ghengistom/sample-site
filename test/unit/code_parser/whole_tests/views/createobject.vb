' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF DocConverter 2015
' Example generated 01/01/2000 

Imports System

' Make sure to add the ActivePDF product .NET DLL(s) to your application.
' .NET DLL(s) are typically found in the products 'bin' folder.

Public Class Examples
  Sub Example()
    ' Instantiate Object
    Dim oDC As APDocConverter.DocConverter = New APDocConverter.DocConverter()
    
    ' Release object: .NET = Yes, COM = Yes
    Dim oOne As APDocConverter.FromPDFOptions = New APDocConverter.FromPDFOptions()
    oOne.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect
    oDC.SetFromPDFOptions(oOne)
    
    ' Release Object
    oOne = Nothing
    
    ' Release object: .NET = No, COM = Yes
    Dim oTwo As APDocConverter.FromPDFOptions = New APDocConverter.FromPDFOptions()
    oTwo.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect
    oDC.SetFromPDFOptions(oTwo)
    
    ' Release object: .NET = Yes, COM = Yes
    Dim oThree As APDocConverter.FromPDFOptions = New APDocConverter.FromPDFOptions()
    oThree.ToWordHeadersAndFootersMode = APDocConverter.ToWordHeadersAndFootersOptions.Detect
    oDC.SetFromPDFOptions(oThree)
    
    ' Release Object
    oThree = Nothing
    
    ' Release Object
    oDC = Nothing
    
    ' Process Complete
    WriteResults("Done!")
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