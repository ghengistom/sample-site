with_svr do
  ConvertPSToPDF relative_file("ps.ps"), relative_file("ps.pdf"), :assert_result => "Server"
end