with_svr do
  PSToPDF relative_file("ps.ps"), relative_file("ps.pdf"), :assert_equal => 0
end