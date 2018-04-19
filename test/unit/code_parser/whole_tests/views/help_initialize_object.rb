# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Server 2009
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
objVAR = WIN32OLE.new("APProduct.Object")


# Release Object
objVAR = ''

# Instantiate Object
oDC = WIN32OLE.new("APDocConv.Object")


# Release Object
oDC = ''

# Instantiate Object
oDCw = WIN32OLE.new("DocConverterWBE.Object")


# Release Object
oDCw = ''

# Instantiate Object
oMER = WIN32OLE.new("APMeridian.Object")


# Release Object
oMER = ''

# Instantiate Object
oSVR = WIN32OLE.new("APServer.Object")


# Release Object
oSVR = ''

# Instantiate Object
oTK = WIN32OLE.new("APToolkit.Object")


# Release Object
oTK = ''

# Instantiate Object
oWG = WIN32OLE.new("APWebGrabber.Object")


# Release Object
oWG = ''


# Release Object
oXT = ''

.with_()
.with_toolkit()
# Instantiate Object
oWG = WIN32OLE.new("APWebGrabber.Object")

intDoPrint = oWG.DoPrint('127.0.0.1', 58585)
if intDoPrint != 0
  puts "Error in DoPrint: #{intDoPrint}"
end
# Instantiate Object
oTK = WIN32OLE.new("APToolkit.Object")

intOpenInputFile = oTK.OpenInputFile(strPath + 'new.pdf')
if intOpenInputFile != 0
  puts "Error in OpenInputFile: #{intOpenInputFile}"
end
oWG.Function('asdf')

# Release Object
oTK = ''


# Release Object
oWG = ''

# Instantiate Object
oDC = WIN32OLE.new("APDocConv.Object")

fPDF = WIN32OLE.new("APDocConverter.FromPDFOptions")
fPDF.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions(fPDF)

# Release Object
fPDF = ''

# Release Object
oDC = ''

fPDF = WIN32OLE.new("APDocConverter.FromPDFOptions")
fPDF.ToWordHeadersAndFootersMode = 0

# Release Object
fPDF = ''
# Instantiate Object
oDC = WIN32OLE.new("APDocConv.Object")

# Snippet with variables
oDC.SetSnippetPropertyToInt = 1
oDC.ArrayProperty = 'Array of numbers and strings'
oDC.ArrayProperty = 1
oDC.ArrayProperty = 18.38
# nil

# Release Object
oDC = ''

fPDF = WIN32OLE.new("APDocConverter.FromPDFOptions")
fPDF.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions(fPDF)

# Release Object
fPDF = ''
oXMP = .GetXmpManager()
oXMP.AddFieldsToXMP = 1
oXMPField = oXMP.GetXMPFieldInfo('name')
strFieldInfo = oXMPField.Name

# Release Object
oXMPField = ''

# Release Object
oXMP = ''
# Process Complete
puts "Done!"