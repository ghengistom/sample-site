# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF CADConverter 2015
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oDC = WIN32OLE.new("APDocConverter.Object")

# Settings specific to CAD conversions
oCAD = WIN32OLE.new("CADConverter.Object")

# Options available for CAD conversions
oCAD.ASCIIHexEncoding = false
oCAD.Color = 0
oCAD.EmbedFonts = 2
oCAD.ExportLayers = 2
oCAD.ExportLayouts = 0
oCAD.FlateCompression = false
oCAD.HatchToBitmapDPI = 150
oCAD.HiddenLineRemoval = false
oCAD.Lineweight = -1
oCAD.OtherHatchesSettings = 0
oCAD.PlotStyleTableName = ''
oCAD.SHXTextAsGeometry = false
oCAD.SimpleGeometryOptimization = false
oCAD.SolidHatchesSettings = 2
oCAD.TrueTypeAsGeometry = false
oCAD.ZoomToExtents = true

# Page size is only set if ZoomToExtents is true
oCAD.SetExtentsPageSize(210, 297)

# Convert the settings to XML and send it to DocConverter
cadXML = oCAD.Serialize()
oDC.SetAddonOptions(cadXML)

# Release Object
oCAD = ''

# Convert the file to PDF
results = oDC.ConvertToPDF(strPath + 'sample.dwg', strPath + 'new.pdf')
if results.DocConverterStatus != 0
  puts "Error with ConvertToPDF:"
  puts "#{results.DocConverterStatus}"
  puts results.Details
  exit 1
end

# Release Object
oDC = ''

# Process Complete
puts "Done!"