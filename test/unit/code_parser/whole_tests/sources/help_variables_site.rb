# You can access variables that may change depending on language anywhere in the code like this:
@vars[:wg][:port] # => 54545 in .NET
@vars[:wg][:port] # => 58585 in COM
@vars[:dc][:port] # => 54545 in .NET
@vars[:dc][:port] # => 58585 in COM
@vars[:mer][:port] # => 54545 in .NET
@vars[:mer][:port] # => 58585 in COM

# You can access information about the example you are running on:
@vars[:product][:name] # => Server
@vars[:product][:version] # => 2009
@vars[:product][:obj] # => svr
@language # => the short form for the currently used language
@language_type # => either :net or :com depending on what language is being output