# You can create snippets of code that will be included in any example and call them like this:
snippet 1

# You can also send variables to your snippet like this:
snippet 1, :stringComment => "Hello World!", :intValue => 0, :arrayValues => ["Array of strings and numbers", 0, 12.56]

# For example to send a complex hash to a snippet:
snippet 1, :hash => {"ps" => ["input.ps", "output.ps.pdf"], "xps" => ["input.xps", "output.xps.pdf"]}

# You could access the hash inside the snippet as follows:
#>>>> @hash["ps"][0]

# You can optionally pass the :category parameter to snippets. Setting this parameter to true will allow the user
# to select which snippet to show from all the snippets in that category
#>>>> snippet 51, :category => true

# If you need to exclude certain snippets from showing in the category list, you can pass the :exclude parameter
# This parameter accepts either an integer or an array of integers.
#>>>> snippet 51, :category => true, :exclude => 52
#>>>> snippet 51, :category => true, :exclude => [52, 53, 55]

# Snippets are written just as any other code is. To access a variable put an @ in front of it's name, like this:
#>>>> comment "#{@myString} #{@myInt} #{@myArray[0]}"
#>>>> comment @myString