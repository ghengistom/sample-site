module DataTypes
  class Variables
    # Setup stringified versions of variable types
    VARIABLE_TYPES = Hash.new
    [:integer, :long, :iresult, :fixnum, :int, :short].each {|t| VARIABLE_TYPES[t] = "int" }
    [:boolean, :bool].each {|t| VARIABLE_TYPES[t] = "bool" }
    [:string, :str].each {|t| VARIABLE_TYPES[t] = "string" }
    VARIABLE_TYPES[:float] = "float"
    VARIABLE_TYPES[:object] = "object"
    VARIABLE_TYPES[:byte] = "byte"
    VARIABLE_TYPES[:enum] = "enum"

    # Setup prefixed versions of variable types
    VARIABLE_PREFIX_TYPES = Hash.new
    [:integer, :long, :iresult, :fixnum, :int, :short].each {|t| VARIABLE_PREFIX_TYPES[t] = "int" }
    [:boolean, :bool].each {|t| VARIABLE_PREFIX_TYPES[t] = "bool" }
    [:string, :str].each {|t| VARIABLE_PREFIX_TYPES[t] = "str" }
    VARIABLE_PREFIX_TYPES[:float] = "float"
    VARIABLE_PREFIX_TYPES[:object] = "obj"
    VARIABLE_PREFIX_TYPES[:byte] = "byte"
    VARIABLE_PREFIX_TYPES[:enum] = "enum"
  end
end