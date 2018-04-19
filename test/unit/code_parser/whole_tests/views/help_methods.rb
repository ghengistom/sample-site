# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Server 2009
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

.MethodName('asdf', '#FF9900', 1, 2.0, true)
.AddEmail()
intStartPrinting = .StartPrinting('file.ps', 'file.pdf')
if intStartPrinting != 0
  puts "Error in StartPrinting: #{intStartPrinting}"
end
intStartPrinting = .StartPrinting('file.ps', 'file.pdf')
if intStartPrinting < 1
  puts "Error in StartPrinting: #{intStartPrinting}"
end
intStartPrinting = .StartPrinting('file.ps', 'file.pdf')
if intStartPrinting > 1
  puts "Error in StartPrinting: #{intStartPrinting}"
end
results = .StartPrinting('file.ps', 'file.pdf')
if results.ServerStatus != 0
  puts "Error with StartPrinting:"
  puts "#{results.ServerStatus}"
  puts results.Details
  exit 1
end
results = .ClosePDF()
if results.ServerStatus != 0
  puts "Error with ClosePDF:"
  puts "#{results.ServerStatus}"
  puts results.Details
  exit 1
end
intBeginStartPrinting = .BeginStartPrinting(strPath + 'file.ps', strPath + 'file.pdf')
if intBeginStartPrinting != 0
  puts "Error in BeginStartPrinting: #{intBeginStartPrinting}"
end
intBeginStartPrinting = .BeginStartPrinting('file.ps', 'file.pdf')
if intBeginStartPrinting < 1
  puts "Error in BeginStartPrinting: #{intBeginStartPrinting}"
end
puts "Error in MethodName: #{VariableName}"
ManualResults = .OpenPDF(strPath + 'Report.pdf')
if results.XtractorStatus != XDK.Results.XtractorStatus.Success
  puts "Error with OpenPDF:"
  puts "#{ManualResults.XtractorStatus}"
  puts results.Details
  exit 1
else
  ExtractedText = .GetTextByLocation(2, 100, 400, 200)
end
oXMP = .GetXMPManager()
# Set a document property
intSetDocumentProperty = oXMP.SetDocumentProperty(2, 'John Doe')
if intSetDocumentProperty != 0
  puts "Error in SetDocumentProperty: #{intSetDocumentProperty}"
end
intSetDocumentProperty = oXMP.SetDocumentProperty(2, 'John Doe')
if intSetDocumentProperty != 0
  puts "Error in SetDocumentProperty: #{intSetDocumentProperty}"
end
intSetDocumentProperty = oXMP.SetDocumentProperty(2, 4)
if intSetDocumentProperty != 0
  puts "Error in SetDocumentProperty: #{intSetDocumentProperty}"
end
oXMP.RemoveDocumentProperty(2)

# Release Object
oXMP = ''
oReleaseOne = .MethodObject()

# Release Object
oReleaseOne = ''
oReleaseTwo = .MethodObject()

# Release Object
oReleaseTwo = ''
oNoRelease = .MethodObject()

# Release Object
oNoRelease = ''
# Process Complete
puts "Done!"