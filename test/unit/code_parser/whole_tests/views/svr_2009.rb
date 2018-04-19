# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Server 2009
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oSVR = WIN32OLE.new("APServer.Object")

intPSToPDF = oSVR.PSToPDF(strPath + 'ps.ps', strPath + 'ps.pdf')
if intPSToPDF != 0
  puts "Error in PSToPDF: #{intPSToPDF}"
end

# Release Object
oSVR = ''

# Process Complete
puts "Done!"