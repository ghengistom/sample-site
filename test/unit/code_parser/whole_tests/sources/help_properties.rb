# This is how you set a property.
Debug :equals => "asdf" # string
Debug :equals => 4 # integer
Debug :equals => true # boolean true
Debug :equals => false # boolean false
Debug :equals => :asdf # asdf will be output, unquoted

# This is how you set a property that will be different in COM and .NET languages.
Debug :equals => {:com => 1, :net => 0}

# Properties that use enumerators
Show :equals => {:com => 1, :net => "IVShow_DocumentTitle", :enum => "IVShow"}

# Properties that use enumerators with a different namespace than the namespace tied to the version
EngineToUse :equals => {:com => 1, :net => "IE", :enum => "ConversionEngine", :namespace => "APWebGrabberInterface"}

# You can also set a variable equal to a property
Debug :equaled => variable("isDebug", "boolean")

# If needed you may append a string to the end of the new variable, like this:
GetUniqueID :equaled => variable("testVar", "int"), :append => ".pdf"