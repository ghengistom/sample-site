# Write content to screen
write_out "Hello World!"

# Output a variable
write_out variable("strVariable")

# Output a variable that is not a string
write_out variable("longNumber"), :tostring => true