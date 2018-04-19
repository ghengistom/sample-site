# Enter methods, one per line, with any options needed.
# Options will be placed one after another in the output language.
MethodName "asdf", "#FF9900", 1, 2.0, true

# To call a method that has no parameters, simply do not include any!
#>>>> AddEmail

# If you are not specifying the object and you want to call a method with no parameters, you MUST put () after the method name.
# This method is not recommened. You should use the object style as shown above.
AddEmail()

# To check the output from a method add :assert_equal symbol and set it equal
# to a number or string to validate a method's output.
StartPrinting "file.ps", "file.pdf", :assert_equal => 0

# You may also use the :assert_lt and :assert_gt properties to check that the output of the method is less than a value
# The following will check to see if the output from StartPrinting is less than 1
StartPrinting "file.ps", "file.pdf", :assert_lt => 1 # less than 1
StartPrinting "file.ps", "file.pdf", :assert_gt => 1 # greater than 1

# Newer activePDF product require a new result class to compare method results with
# To use this new result object, you must use the :assert_result parameter
# The parameter must be set to the string prefix of the result class you want to use, like this:
# Examples: "Server", "WebGrabber", "Xtractor"
StartPrinting "file.ps", "file.pdf", :assert_result => "Server"

# If you need to call a method equal to the result object and it has no parameters
ClosePDF(:assert_result => "Server")

# Sometimes the method returns a variable of a special type.
# To control what that type is, use the :assert_equal_type parameter:
BeginStartPrinting relative_file("file.ps"), relative_file("file.pdf"), :assert_equal => 0, :assert_equal_type => "long"
BeginStartPrinting "file.ps", "file.pdf", :assert_lt => 1, :assert_equal_type => "long"

# You can call the error method by using the following code:
error "MethodName", "VariableName" # This will output a call to the error method, with the names as indicated.

# To manually create the result check after calling a method that equals the result object
OpenPDF relative_file("Report.pdf"), :var => variable("ManualResults", :"XDK.Results.XtractorResult")
iff ("results.XtractorStatus"), :not_equals => :"XDK.Results.XtractorStatus.Success" do
  error "OpenPDF", "ManualResults", :assert_result => "Xtractor", :result_variable => "ManualResults"
  elsee do
    GetTextByLocation 2, 100, 400, 200, :var => variable("ExtractedText", :"XDK.Results.TextResult")
  end
end

# Enumerators in a method
# The object will be released by default, if you do not want to release an object in .NET add ":release_net => false"
# This is primarily for Toolkit as it uses dispose
GetXMPManager :object => "oXMP", :class => "APToolkitNET.XMPManager", :release_net => 'false' do
  comment "Set a document property"
  # Set the hash containing the enumerator information to a variable
  # Set the variable as the parameter in the method call
  enum = {:com => 2, :net => "Author", :enum => "XMPProperty"}
  SetDocumentProperty enum, "John Doe", :assert_equal => 0, :assert_equal_type => "long"

  # If the enumerator uses a different namespace then the version namespace
  enum = {:com => 2, :net => "Author", :enum => "XMPProperty", :namespace => "APToolkitNET"}
  SetDocumentProperty enum, "John Doe", :assert_equal => 0, :assert_equal_type => "long"
  
  # If the method requires two enumerators
  enum1 = {:com => 2, :net => "Author", :enum => "XMPTest"}
  enum2 = {:com => 4, :net => "Title", :enum => "XMPTest"}
  SetDocumentProperty enum1, enum2, :assert_equal => 0, :assert_equal_type => "long"
  
  # Method has just one parameter
  enum = {:com => 2, :net => "Author", :enum => "XMPProperty"}
  RemoveDocumentProperty enum
end

# Create object from method and release it
MethodObject :object => "oReleaseOne", :class => "Product.Class" do
end
MethodObject :object => "oReleaseTwo", :class => "Product.Class", :release_net => true do
end

# Create object from method and do not release it in .NET
MethodObject :object => "oNoRelease", :class => "Product.Class", :release_net => false do
end