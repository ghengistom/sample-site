# Write out a comment
comment "Hello World!"

# Write out COM or .NET specific comments
comment :com => "Hello COM!"
comment :net => "Hello .NET!"

# Write out to both COM and .NET with one line of code
comment :com => "Hello COM!", :net => "Hello .NET!"

# Some characters need to be escaped in ruby such as \ and "
comment "You can display a \\ and also a \" in the comment"
