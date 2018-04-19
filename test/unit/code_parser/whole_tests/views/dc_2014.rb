# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF DocConverter 2014
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oDC = WIN32OLE.new("APDocConverter.Object")

results = oDC.ConvertToPDF(strPath + 'word.doc', strPath + 'word.pdf')
if results.DocConverterStatus != 0
  puts "Error with ConvertToPDF:"
  puts "#{results.DocConverterStatus}"
  puts results.Details
  exit 1
end

results = oDC.ConvertFromPDF(strPath + 'word.pdf', strPath + 'word.pdf', 1)
if results.DocConverterStatus != 0
  puts "Error with ConvertFromPDF:"
  puts "#{results.DocConverterStatus}"
  puts results.Details
  exit 1
end

# Release Object
oDC = ''

# Process Complete
puts "Done!"