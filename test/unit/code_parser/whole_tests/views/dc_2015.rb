# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF DocConverter 2015
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

# Instantiate Object
oDC = WIN32OLE.new("APDocConverter.Object")

# Settings specific to other formats created with from PDF conversions
# are set using the FromPDFOptions object
fPDF = WIN32OLE.new("APDocConverter.FromPDFOptions")

# To Word options
fPDF.ToWordHeadersAndFootersMode = 0

# To Excel options
fPDF.ToExcelAutoDetectSeparators = true
fPDF.ToExcelTablesFromContent = 0

# To Image options
fPDF.ToImagePageDPI = 300

# Send the from PDF settings to DocConverter
oDC.SetFromPDFOptions(fPDF)

# Release Object
fPDF = ''

# Convert the document from PDF to another format
# The second parameter determines the output file format
#  0 = .doc
#  1 = .docx
#  2 = .xls
#  3 = .ppt
#  4 = .html
#  5 = .txt
#  6 = .bmp
#  7 = .jpg
#  8 = .png
#  9 = .tif
# 10 = .pdf (PDF/A)
# 11 = Verify PDF/A compliance
# 12 = .rtf
# 13 = .gif
# 14 = .tif (multipage)
results = oDC.ConvertFromPDF(strPath + 'PDF.pdf', 1, strPath + 'PDF.docx')
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