with_dc do |dc|
  ConvertToPDF relative_file("word.doc"), relative_file("word.pdf"), :assert_result => "DocConverter"
  br
  if @language_type == :net
    case @language
    when "cf"
      output_for_language :cf => 'dcFromPDF = CreateObject(".NET", "APDocConverter.FromPDFFunction", "%s");' % [@vars[:product][:path]]
      @from_pdf_value = :"dcFromPDF.ToWord"
    else
      @from_pdf_value = :"oDC.FromPDFFormat = APDocConverter.FromPDFFunction.ToWord"
    end
  else
    @from_pdf_value = 1
  end
  ConvertFromPDF relative_file("word.pdf"), relative_file("word.pdf"), @from_pdf_value, :assert_result => "DocConverter"
end