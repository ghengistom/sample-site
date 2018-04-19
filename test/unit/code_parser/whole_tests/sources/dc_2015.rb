with_dc do |dc|
  comment "Settings specific to other formats created with from PDF conversions"
  comment "are set using the FromPDFOptions object"
  createobject "fPDF", :com => "APDocConverter.FromPDFOptions", :class => "APDocConverter.FromPDFOptions", :call => "APDocConverter.FromPDFOptions()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.Net35.dll" do
    br
    comment "To Word options"
    if @language_type == :net
      ToWordHeadersAndFootersMode :equals => :"APDocConverter.ToWordHeadersAndFootersOptions.Detect"
    else
      ToWordHeadersAndFootersMode :equals => 0
    end
    br
    comment "To Excel options"
    if @language_type == :net
      ToExcelAutoDetectSeparators :equals => true
      ToExcelTablesFromContent :equals => :"APDocConverter.ToExcelTablesFromContentOptions.Default"
    else
      ToExcelAutoDetectSeparators :equals => true
      ToExcelTablesFromContent :equals => 0
    end
    br
    comment "To Image options"
    if @language_type == :net
      ToImagePageDPI :equals => 300
    else
      ToImagePageDPI :equals => 300
    end
    br
    comment "Send the from PDF settings to DocConverter"
    dc.SetFromPDFOptions @object_variable.to_sym
  end
  br
  @file_doc = "PDF.docx"
  @file_pdf = "PDF.pdf"  
  comment "Convert the document from PDF to another format"
  comment "The second parameter determines the output file format"
  if @language_type == :net
    case @language
    when "cf"
      output_for_language :cf => 'dcFromPDF = CreateObject(".NET", "APDocConverter.FromPDFFunction", "%s");' % [@vars[:product][:path]]
      @from_pdf_value = :"dcFromPDF.ToWordDocX"
    else
      @from_pdf_value = :"APDocConverter.FromPDFFunction.ToWordDocX"
    end
  else
    comment " 0 = .doc"
    comment " 1 = .docx"
    comment " 2 = .xls"
    comment " 3 = .ppt"
    comment " 4 = .html"
    comment " 5 = .txt"
    comment " 6 = .bmp"
    comment " 7 = .jpg"
    comment " 8 = .png"
    comment " 9 = .tif"
    comment "10 = .pdf (PDF/A)"
    comment "11 = Verify PDF/A compliance"
    comment "12 = .rtf"
    comment "13 = .gif"
    comment "14 = .tif (multipage)"
    @from_pdf_value = 1
  end
  ConvertFromPDF relative_file(@file_pdf), @from_pdf_value, relative_file(@file_doc), :assert_result => "DocConverter"
end