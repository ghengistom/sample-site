# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Toolkit 2011
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oTK = WIN32OLE.new("APToolkit.Object")

# Here you can place any code that will alter the output file
# Such as adding security, setting page dimensions, etc.

# Create the new PDF file
intOpenOutputFile = oTK.OpenOutputFile(strPath + 'new.pdf')
if intOpenOutputFile != 0
  puts "Error in OpenOutputFile: #{intOpenOutputFile}"
end

# Open the template PDF
intOpenInputFile = oTK.OpenInputFile(strPath + 'PDF.pdf')
if intOpenInputFile != 0
  puts "Error in OpenInputFile: #{intOpenInputFile}"
end

# Here you can call any Toolkit functions that will manipulate
# the input file such as text and image stamping, form filling, etc.

# Copy the template (with any changes) to the new file
# Start page and end page, 0 = all pages
intCopyForm = oTK.CopyForm(0, 0)
if intCopyForm != 1
  puts "Error in CopyForm: #{intCopyForm}"
end

# Close the new file to complete PDF creation
oTK.CloseOutputFile()

# Release Object
oTK = ''

# Process Complete
puts "Done!"