# Descriptions can contain textile markup for easy formating
# See http://redcloth.org/textile/ for more information on Textile
description "Use _DoPrint_ to *print* documents or whatever."

# Descriptions may contain links as well
# See http://redcloth.org/textile/ for more information on Textile
description 'Check out the ["DoPrint":/WebGrabber Enterprise/2009/DoPrint] function for more info.'

# To use a snippet
snippet 31

# To enter remarks
# remarks support textile markup
remarks "*Warning*: make sure you have a glass of milk ready _before_ eating that donut."

# To enter parameters, again descriptions support textile markup
# name, type, description
parameter "IP Address", :string, "Set this to the IP address of the server"
parameter "Port Number", :integer, "50505 - *COM* or 12412 - *NET*"

# To enter results
result "Status", :integer, :codes => {0 => "Success", 210 => "Not good"}  # use for both, with return codes
result "Status", :iresult, :language_type => :net                         # use for .NET only

# To set the property to either a getter or setter.
# Don't use this setting at all to use both.
property :get # by default it's both
property :set # by default it's both

# For properties, we need to set the value they will be assiged.
# name, type, description
value "Width", :integer, "The width of the output file, in PDF units."

# COM vs .NET languages
# You may also specify the type of the value with a Hash containing :com and :net properties..
value "PDFFormat", {:com => :int, :net => :boolean}, "Set the output PDF to be either PDF or PDF/A."

# You may also specify a description to be appended to the main description depending on the language selected
value "PDFFormat", {:com => :int, :net => :boolean}, "Set the output PDF to be either PDF or PDF/A.", :net => "True/False for .NET", :com => "1 or 0 for COM"

# This also works for parameters
parameter "PDFFormat", {:com => :int, :net => :boolean}, "Set the output PDF to be either PDF or PDF/A.", :net => "True/False for .NET", :com => "1 or 0 for COM"