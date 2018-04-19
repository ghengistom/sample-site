# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Server 2012
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oSVR = WIN32OLE.new("APServer.Object")

# Convert the PostScript file into PDF
results = oSVR.ConvertPSToPDF(strPath + 'file.ps', strPath + 'file.pdf')
if results.ServerStatus != 0
  puts "Error with ConvertPSToPDF:"
  puts "#{results.ServerStatus}"
  puts results.Details
  exit 1
end

# Release Object
oSVR = ''

# Process Complete
puts "Done!"