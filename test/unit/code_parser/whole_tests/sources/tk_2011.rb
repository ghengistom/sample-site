with_tk do |tk|
  comment "Here you can place any code that will alter the output file"
  comment "Such as adding security, setting page dimensions, etc."
  br
  comment "Create the new PDF file"
  OpenOutputFile relative_file("new.pdf"), :assert_equal => 0
  br
  comment "Open the template PDF"
  OpenInputFile relative_file("PDF.pdf"), :assert_equal => 0
  br
  comment "Here you can call any Toolkit functions that will manipulate"
  comment "the input file such as text and image stamping, form filling, etc."
  br
  comment "Copy the template (with any changes) to the new file"
  comment "Start page and end page, 0 = all pages"
  CopyForm 0, 0, :assert_equal => 1
  br
  comment "Close the new file to complete PDF creation"
  CloseOutputFile()
end