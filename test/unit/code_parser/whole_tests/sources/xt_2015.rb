with_xt do
  OpenPDF relative_file("PDF.pdf"), :assert_result => :"XDK.Results.XtractorResult"
end