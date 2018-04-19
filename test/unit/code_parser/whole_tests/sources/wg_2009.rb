with_wg do |wg|
  comment "Perform the HTML to PDF conversion"
  DoPrint "127.0.0.1", @vars[:wg][:port], :assert_equal => 0
  br
  comment "Cleans up all internal string variables used during conversion"
  comment "By default variables are deleted 3 minutes after the conversion"
  CleanUp "127.0.0.1", @vars[:wg][:port]
end