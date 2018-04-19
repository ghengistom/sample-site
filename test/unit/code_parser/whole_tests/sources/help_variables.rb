# variable(name, type, value)
# variable(name, type, concat("comma seperated values"))
# Setting the value is optional. If you do not set the value the the variable
# will only be declared in the languages that support declarations.
# Setting no value and no type will default to a string.

# The following types are available
# String
variable("strVariable")
variable("strText", "string", "asdf asdf")

# Integer
variable("y", "int", 10)

# Short
variable("shortVariable", "short", 30000)

# Long
variable("longVariable", "long", 100000)

# Float
variable("floatVariable", "float", 46.72)

# Bool
variable("boolVariable", "bool", true)

# Byte
variable("byteVariable", "byte") # this will set the variable to a byte type in the languages that support it, or "string"

# Array - Generic
variable("arrayNames", "array", ["James", "John"])

# Array - String
variable("arrayFiles", "array_string", ["asdf.pdf", "asdf1.pdf"])
variable("arrayFiles2", "array_string", ["#{relative_file("cover.pdf")}".to_sym, "5pageLI.pdf", "6pageAA.pdf"])

# Array - Float
variable("arrayFloats", "array_float", [4.2, 6.7, 1.3, 9.3])

# Array - .NET PointF
# Must have even number of points specified in the array with the format "0.0"
variable("arrayPoints", "array_point", [PointF.new(210.0, 776.0), PointF.new(246.0, 776.0), PointF.new(210.0, 740.0), PointF.new(246.0, 740.0)])

# Class
# Must use ":" to denote a symbol to carry over the class name as is
variable("ExtractedText", :"XDK.Results.TextResult")

# You can use these variables again in a variety of locations just by calling variable again
Debug :equals => variable("boolVariable")
AddURLBookmark "activePDF.com", variable("strURL")

# If you need to combine multiple strings together in the output language, use the concat method.
# This will output the equivalent of text = "asdf" + "1234" + strPath + "asdf.pdf"
variable "text", "string", concat("asdf", "1235", relative_file("asdf.pdf"))

# To set a variable equal to the output of a method, set the :var option and pass it a variable.
AddBookmarks "asdf", 0, "some_page", :var => variable("AddBookmarksOutput", "int")
