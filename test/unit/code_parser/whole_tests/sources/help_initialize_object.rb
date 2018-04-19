# Initialize a product for use by declaring the object

# Use current version
with_version do |ver|
end

# To specify a specific product

# DocConverter
with_dc do |dc|
end

# DocConverter WBE
with_dcw do |dc|
end

# Meridian
with_mer do |mer|
end

# Server
with_svr do |s|
end

# Toolkit
with_tk do |tk|
end

# WebGrabber
with_wg do |wg|
end

# Xtractor
with_xt do |xt|
end

# This will initialize the product that the example being viewed references
send "with_#{@vars[:product][:obj]}" do

end

# You can initialize other products even while another product is in use
with_toolkit do |tk|
  tk.JPEGToPDF relative_file("input.jpg"), relative_file("output.pdf")
end

# Using two different products together
with_wg do |wg|
  DoPrint "127.0.0.1", @vars[:wg][:port], :assert_equal => 0
  with_tk do |tk|
    OpenInputFile relative_file("new.pdf"), :assert_equal => 0
    # to use a WG function inside the Toolkit object
    wg.Function "asdf"
  end
end

# Custom method to instantiate an object without having it hard coded in the site.
# This is a great option for sub objects of the products
# The object will be released, if you do not want to release an object in .NET add ":release_net => false"
with_dc do |dc|
  createobject "fPDF", :com => "APDocConverter.FromPDFOptions", :class => "APDocConverter.FromPDFOptions", :call => "APDocConverter.FromPDFOptions()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.Net35.dll" do
    if @language_type == :net
      ToWordHeadersAndFootersMode :equals => :"APDocConverter.ToWordHeadersAndFootersOptions.Detect"
    else
      ToWordHeadersAndFootersMode :equals => 0
    end
    dc.SetFromPDFOptions :"fPDF"
  end
end

createobject "fPDF", :release_net => false, :com => "APDocConverter.FromPDFOptions", :class => "APDocConverter.FromPDFOptions", :call => "APDocConverter.FromPDFOptions()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.Net35.dll" do
  if @language_type == :net
    ToWordHeadersAndFootersMode :equals => :"APDocConverter.ToWordHeadersAndFootersOptions.Detect"
  else
    ToWordHeadersAndFootersMode :equals => 0
  end
end

# If using create object in a snippet and need to access a function of the outer
# object you need to pass the object in a variable to the snippet for use
with_dc do |dc|
  @outside_object = dc
  snippet 1
end
# snippet 999 would then use the @outside_object variable to pass in the outer object
createobject "fPDF", :com => "APDocConverter.FromPDFOptions", :class => "APDocConverter.FromPDFOptions", :call => "APDocConverter.FromPDFOptions()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.Net35.dll" do
  if @language_type == :net
    ToWordHeadersAndFootersMode :equals => :"APDocConverter.ToWordHeadersAndFootersOptions.Detect"
  else
    ToWordHeadersAndFootersMode :equals => 0
  end
  # @object_variable.to_sym means to use the current object. This can't be a 
  # string of the object name because it needs to be properly converted for 
  # something like php which appends $ to the object name.
  @outside_object.SetFromPDFOptions @object_variable.to_sym
end

# Create objects from method calls
GetXmpManager :object => "oXMP", :class => "APToolkitNET.XMPManager" do
  AddFieldsToXMP :equals => 1
  # Create an object from a method of the newly created object from a method
  GetXMPFieldInfo "name", :object => "oXMPField", :class => "APToolkitNET.XMPFieldInfo" do
    Name :equaled => variable("strFieldInfo")
  end
end