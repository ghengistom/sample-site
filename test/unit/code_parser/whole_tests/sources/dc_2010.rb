with_dc do |dc|
  Submit "127.0.0.1", @vars[:dc][:port], relative_file("word.doc"), relative_file(), relative_file(), relative_file(), "", "", false, "", :assert_equal => 0, :assert_equal_type => :long
end