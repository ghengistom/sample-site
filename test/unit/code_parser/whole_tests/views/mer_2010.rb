# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Meridian 2010
# Example generated 01/01/2000 

require 'win32ole'

# Instantiate Object
oMER = WIN32OLE.new("APMeridian.Object")

intWait = oMER.Wait(30)
if intWait != 0
  puts "Error in Wait: #{intWait}"
end

# Release Object
oMER = ''

# Process Complete
puts "Done!"