with_dcw do |dc|
  ConvertToPDF relative_file("word.doc"), relative_file("word.pdf"), :assert_equal => 0
end