with_wg do |wg|
  # Basic Example for Product Snippet
  @outfile = "basic.pdf"
  # SupportedEngine = ie, native, both
  @SupportedEngine = "both"
  
  comment "C:\\ProgramData\\activePDF\\Logs\\"
  Debug :equals => true
  br

  LinearizePDF :equals => true
  br

  case @language_type
  when :net
    comment "Set the amount of time before a request will time out"
    case @language
    when "cf"
      Timeout :equals => 40
    else
      TimeoutSpan :equals => :"new TimeSpan(0, 0, 40)"
    end
  when :com
    comment "Set the amount of seconds before a request will time out"
    Timeout :equals => 40
  else
  end
  br

  comment "Margins (Top, Bottom, Left, Right) 1.0 = 1\""
  SetMargins 0.75, 0.75, 0.75, 0.75
  br

  comment "0 = Portrait, 1 = Landscape"
  Orientation :equals => 0
  br

  # Show the common functions for the engine that is being rendered
  comment "Rendering engine used for the HTML"
  comment :com => "0 = Native, 1 = IE"
  EngineToUse :equals => {:net => "IE", :com => 1, :namespace => "APWebGrabberInterface", :enum => "ConversionEngine"}
  br

  comment "Convert the HTML background (IE engine only)"
  PrintBackground :equals => true
  br

  comment "PDF output location and filename"
  OutputDirectory :equals => relative_file("")
  NewDocumentName :equals => @outfile
  br

  @URLToConvert = "http://examples.activepdf.com/samples/doc"

  comment "HTML to convert"
  comment "Examples:"
  comment "http://domain.com/path/file.aspx"
  comment "c:\\folder\\file.html"
  URL :equals => @URLToConvert
  br

  comment "Perform the HTML to PDF conversion"
  if @language_type == :net
    ConvertToPDF :assert_result => "WebGrabber"
  else
    ConvertToPDF "127.0.0.1", 52525, :assert_result => "WebGrabber"
  end
end