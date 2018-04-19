# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF DocConverter Enterprise 2010
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oDC = WIN32OLE.new("APDocConv.Object")

intSubmit = oDC.Submit('127.0.0.1', 58585, strPath + 'word.doc', strPath, strPath, strPath, '', '', false, '')
if intSubmit != 0
  puts "Error in Submit: #{intSubmit}"
end

# Release Object
oDC = ''

# Process Complete
puts "Done!"