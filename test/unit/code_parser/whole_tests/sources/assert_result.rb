with_svr do
  comment "Convert the PostScript file into PDF"
	ConvertPSToPDF relative_file("file.ps"), relative_file("file.pdf"), :assert_result => "Server"
end