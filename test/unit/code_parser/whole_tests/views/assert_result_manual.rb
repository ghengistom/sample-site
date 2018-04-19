# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Xtractor 2015
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

results = oXT.OpenPDF(strPath + 'PDF.pdf')
if results.XtractorStatus != XDK.Results.XtractorStatus.Success
  puts "Error with OpenPDF:"
  puts "#{results.XtractorStatus}"
  puts results.Details
  exit 1
else
  ExtractedText = oXT.GetTextByLocation(2, 100, 400, 200)
end
oXT.ClosePDF()

# Release Object
oXT = ''

# Process Complete
puts "Done!"