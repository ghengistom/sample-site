# Write an if statement using the method "iff".
# The first parameter is the variable to check. You must cast this as a variable.
# Set the second parameter to a hash specifing how to check the value.
#   This can be one of:
#     * :equals - ensure variable equals this
#     * :gt     - ensure variable is greater than this
#     * :lt     - ensure variable is less than this
# Set the block to anything that will be contained in the if statement.
iff variable("asdf", "int"), :equals => 0 do
  comment "If testVar is 0 then call stop printing"
  Whatever "input.pdf", 0, "output.pdf"
end

# You can optionally set an else statement inside the if statement, like this:
iff variable("some_var", "int"), :lt => 0 do
  conmment "This will execute if the if is true"
  elsee do
    comment "This will execute if it's false"
  end
end

# You can also use previously assigned variables
iff variable("testVar"), :equals => 0 do
  StartPrinting :equals => "123"
end