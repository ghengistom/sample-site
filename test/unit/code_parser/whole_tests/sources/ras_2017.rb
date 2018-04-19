with_version do |ver|
    comment "Open PDF"
    OpenFile(relative_file("doc.pdf"))
    br
    comment "Get page count of open file"
    NumPages :assert_lt => 1, :var => variable("pageCount", "int")
    br
    forr "currentPage", 1, variable("pageCount") do
        # Show :equals => {:com => 1, :net => "IVShow_DocumentTitle", :enum => "IVShow"}
        comment "Image Format"
        comment :com => "1 = RGB"
        comment :com => "2 = JPEG"
        comment :com => "3 = TIFF"
        comment :com => "4 = PNG"
        comment :com => "5 = BMP"
        ImageFormat :equals => {:com => 2, :net => "ImgJPEG", :enum => "ImageType"}
        br
        comment "Output Type"
        comment :com => "1 = Stream"
        comment :com => "2 = File"
        OutputFormat :equals => {:com => 2, :net => "OutFile", :enum => "OutputFormatType"}
        br
        comment "Other settings"
        OutputFileName :equals => relative_file(concat("doc", variable("currentPage"), ".jpg"))
        JPEGQuality :equals => 72
        IncludeAnnotations :equals => true
        br
        comment "Render the current page"
        RenderPage variable("currentPage")
    end
    br
    comment "Finished rendering pages, close file"
    CloseFile();
end