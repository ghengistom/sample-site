with_xt do |xt|
  OpenPDF relative_file("PDF.pdf"), :var => variable("results", :"XDK.Results.XtractorResult")
  iff ("results.XtractorStatus"), :not_equals => :"XDK.Results.XtractorStatus.Success" do
    error "OpenPDF", "results", :assert_result => "Xtractor", :result_variable => "results"
    elsee do
      GetTextByLocation 2, 100, 400, 200, :var => variable("ExtractedText", :"XDK.Results.TextResult")
    end
  end
  ClosePDF()
end