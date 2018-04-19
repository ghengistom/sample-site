# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF WebGrabber 2016
# Example generated 01/01/2000 

require 'win32ole'

# Instantiate Object
oWG = WIN32OLE.new("APWebGrabber.Object")

results = oWG.ConvertToPDF('127.0.0.1', 90)
if results.WebGrabberStatus != 0
  puts "Error with ConvertToPDF:"
  puts "#{results.WebGrabberStatus}"
  puts results.Details
  exit 1
end

# Release Object
oWG = ''

# Process Complete
puts "Done!"