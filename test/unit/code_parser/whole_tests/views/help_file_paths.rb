# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Server 2009
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

intImageToPDF = .ImageToPDF(strPath + 'IMG.jpg', strPath + 'IMG.pdf')
if intImageToPDF != 1
  puts "Error in ImageToPDF: #{intImageToPDF}"
end
# Process Complete
puts "Done!"