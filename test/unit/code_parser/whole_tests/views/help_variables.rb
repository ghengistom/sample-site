# Copyright (c) 2000 ActivePDF, Inc.
# ActivePDF Server 2009
# Example generated 01/01/2000 

require 'win32ole'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

strText = 'asdf asdf'
y = 10
shortVariable = 30000
longVariable = 100000
floatVariable = 46.72
boolVariable = true
arrayNames = ['James', 'John']
arrayFiles = ['asdf.pdf', 'asdf1.pdf']
arrayFiles2 = [strPath + 'cover.pdf', '5pageLI.pdf', '6pageAA.pdf']
arrayFloats = [4.2, 6.7, 1.3, 9.3]
arrayPoints = [210.0, 776.0, 246.0, 776.0, 210.0, 740.0, 246.0, 740.0]
.Debug = boolVariable
.AddURLBookmark('activePDF.com', strURL)
text = 'asdf' + '1235' + strPath + 'asdf.pdf'.to_s
AddBookmarksOutput = .AddBookmarks('asdf', 0, 'some_page')
# Process Complete
puts "Done!"