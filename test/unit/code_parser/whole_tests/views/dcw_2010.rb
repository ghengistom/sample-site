# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF DocConverter WBE 2010
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oDCw = WIN32OLE.new("DocConverterWBE.Object")

intConvertToPDF = oDCw.ConvertToPDF(strPath + 'word.doc', strPath + 'word.pdf')
if intConvertToPDF != 0
  puts "Error in ConvertToPDF: #{intConvertToPDF}"
end

# Release Object
oDCw = ''

# Process Complete
puts "Done!"