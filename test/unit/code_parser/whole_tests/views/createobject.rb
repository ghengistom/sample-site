# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF DocConverter 2015
# Example generated 01/01/2000 

require 'win32ole'

# Instantiate Object
oDC = WIN32OLE.new("APDocConverter.Object")

# Release object: .NET = Yes, COM = Yes
oOne = WIN32OLE.new("APDocConverter.FromPDFOptions")
oOne.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions(oOne)

# Release Object
oOne = ''

# Release object: .NET = No, COM = Yes
oTwo = WIN32OLE.new("APDocConverter.FromPDFOptions")
oTwo.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions(oTwo)

# Release Object
oTwo = ''

# Release object: .NET = Yes, COM = Yes
oThree = WIN32OLE.new("APDocConverter.FromPDFOptions")
oThree.ToWordHeadersAndFootersMode = 0
oDC.SetFromPDFOptions(oThree)

# Release Object
oThree = ''

# Release Object
oDC = ''

# Process Complete
puts "Done!"