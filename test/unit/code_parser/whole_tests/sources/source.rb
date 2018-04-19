with_tk do |tk|
  imports "asdf"
  variable "asdf", "string", concat("asdf","1234", relative_file("asdf.pdf"))
  AddEmail()
  tk.AddEmail
  comment "Create the new PDF file"
  OpenOutputFile relative_file("new.pdf"), :assert_equal => 0
  br
  comment "Open the template PDF"
  OpenInputFile relative_file("PDF.pdf"), :assert_equal => 0
  br
  comment "Add a 'Confidential' watermark by setting text transparency"
  comment "Rotation and color of the text along with the fill mode are set"
  SetHeaderFont "Helvetica", 90
  SetHeaderTextTransparency 0.6, 0.6
  SetHeaderRotation 45
  SetHeaderTextStrokeColor 255, 0, 0, 0
  SetHeaderTextFillMode 1
  SetHeaderText 154, 184, "Confidential"
  ResetHeaderTextTransparency()
  SetHeaderTextFillMode 0
  MyProperty :equals => 1
  Debug :equals => {:com => :asdf, :net => "jkl;"}
  tk.Debug :equaled => variable("isDebug", "boolean")
  br
  comment "Add a 'Top Secret' watermark by placing text in the background"
  SetHeaderFont "Helvetica", 72
  SetHeaderTextBackground 0
  SetHeaderTextColor 200, 200, 200, 0
  SetHeaderText 154, 300, "Top Secret"
  SetHeaderTextBackground 1
  ResetHeaderTextColor()
  SetHeaderRotation 0
  br
  comment "Add the document title to the bottom center of the page"
  SetHeaderFont "Helvetica", 12
  variable("strTitle", "string", "Lorem Ipsum")
  GetHeaderTextWidth variable('strTitle'), :var => variable("textWidth", "float")
  SetHeaderText :"(612 - #{variable('textWidth')}) / 2", 32, variable('strTitle')
  br
  comment "Add page numbers to the bottom left of the page"
  SetHeaderFont "Helvetica", 12
  SetHeaderWPgNbr 72, 32, "Page %p", 1
  br
  comment "Add a mulitline print box for an 'approved' message in header"
  SetHeaderTextFillMode 2
  SetHeaderTextColorCMYK 0, 0, 0, 20
  SetHeaderTextStrokeColorCMYK 0, 0, 0, 80
  SetHeaderMultilineText "Helvetica", 22, 344, 766, 190, 86, "Approved on January 17th, 2021", 2
  br
  comment "Add some lines to the footer and top right corner of the page"
  SetHeaderGreyBar 72, 52, 468, 1, 0.8
  SetHeaderHLine 340, 544, 724, 1
  SetHeaderVLine 724, 648, 544, 1
  tk.GetUniqueID :equaled => variable("testVar", "int"), :append => ".pdf"
  br
  comment "Use the Header Image properties to add some images to the footer"
  comment :net => "Net comment", :com => "Com comment"
  SetHeaderImage relative_file("BMP.bmp"), 375.0, 13.0, 0.0, 0.0, true
  SetHeaderJPEG relative_file("JPEG.jpg"), 436.0, 9.0, 0.0, 0.0, true
  SetHeaderTIFF relative_file("TIFF.tif"), 500.0, 15.0, 0.0, 0.0, true
  br
  comment "Copy the template (with the stamping changes) to the new file"
  comment "Start page and end page, 0 = all pages"
  CopyForm 0, 0, :assert_equal => 1
  StartPrinting relative_file("PDF.pdf"), :assert_equal => 0, :assert_equal_type => "long"
  StartPrinting "file.ps", "file.pdf", :assert_gt => 1, :assert_equal_type => "long"
  StartPrinting "file.ps", "file.pdf", :assert_lt => 1, :assert_equal_type => "long"
  iff variable("some_var", "int"), :equals => 0 do
    LinearizeFile relative_file("PDF.pdf"), relative_file("new.pdf"), "", :assert_gt => 0
  end
  iff variable("some_var", "int"), :gt => 0 do
    LinearizeFile relative_file("PDF.pdf"), relative_file("new.pdf"), "", :assert_gt => 0
  end
  iff variable("some_var", "int"), :lt => 0 do
    conmment "This is true statement"
    elsee do
      comment "This is an else"
      error "asdf", "234"
    end
  end
  br
  comment "Close the new file to complete PDF creation"
  snippet 1, :stringComment => 'Snippet comment from variable!'
  with_svr do |svr|
    tk.CloseOutputFile()
    svr.CloseOutputFile()
    CloseOutputFile()
  end
  
  comment @vars[:product][:name]
  
  output_for_language :cs => "cs", :vb => "vb", :vbs => "vbs", :cf => "cf", :else => "line 1"
  output_for_language :php => "php", :asp => "asp", :ruby => "ruby", :ps => "ps", :else => "line 2"
  output_for_language :else => "else test"

  switch variable("grade") do
    casee "A" do
      comment "You got an A!"
    end
    casee "B" do
      comment "You got a B!"
    end
    default do
      comment "This is the default."
    end
  end

  NumPages :var => variable("count", "integer") 
  forr "currentPage", 10, variable("count") do
    comment "asdf"
  end
end