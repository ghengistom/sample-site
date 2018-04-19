# Check product or version to output specific code
# Can use any of the example variables
case @vars[:product][:name]
when "WebGrabber", "DocConverter"
  comment "Something for WG and DC"
when "Server"
  comment "Something for Server"  
else
  
end

case @language_type
when :net
  comment "Something for .NET"
when :com
  comment "Something for COM"
end

# Use ruby comments in the code by starting the sentance with "#"

# Put a variable in a starting
comment "This applies to #{@language_type} only"

# Set a default value for a variable in a snippet
# You can then in the main example that calls the snippet 
# set a value for the variable if something other than default is needed
@FileName ||= "test.pdf"