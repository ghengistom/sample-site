# For loops:
# If you need to loop up to the output of a property or method, you will need to set that to a variable first
# Syntax: forr <Name of count variable>, <Start counting at>, <count up to>
TotalPages :var => variable("asdf", "integer") 
forr "currentPage", 10, variable("asdf") do
  comment "asdf"
end