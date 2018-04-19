# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF WebGrabber Enterprise 2009
# Example generated 01/01/2000 

require 'win32ole'

# Instantiate Object
oWG = WIN32OLE.new("APWebGrabber.Object")

# Perform the HTML to PDF conversion
intDoPrint = oWG.DoPrint('127.0.0.1', 58585)
if intDoPrint != 0
  puts "Error in DoPrint: #{intDoPrint}"
end

# Cleans up all internal string variables used during conversion
# By default variables are deleted 3 minutes after the conversion
oWG.CleanUp('127.0.0.1', 58585)

# Release Object
oWG = ''

# Process Complete
puts "Done!"