# New code situations with Spooler 2017
# Calling a method using result object inside the open and close of a method object.
# Reason for this is to make sure the object isn't released before it's needed with another method call.
# .NET doesn't release the object when using dispose so this is a concern with COM.
# Had to make the error handler check global so that it worked inside another object.

@custom ||= true
@printer ||= "Microsoft Print to PDF"
@object_name ||= self

with_version do |ver|
  @object_name = ver
  
  comment "Use the PrinterInfo object to retrieve current settings"
  comment "and available options for the specified printer."
  PrinterInfo "Microsoft Print to PDF", :release_net => false, :object => "oPI", :class => "APSpoolerNET.PrinterInfo" do
    br
    AvailableDPI :equaled => variable("arrayAvailableDPIs", "array")
    BinSources :equaled => variable("arrayBinSources", "array")
    Collate :equaled => variable("isCollate", "boolean")
    ColorMode :equaled => variable("valColorMode", :"APSpoolerNET.ColorMode")
    DPI :equaled => variable("valDPI", "int")
    Duplex :equaled => variable("valDuplex", :"APSpoolerNET.DuplexMode")
    FormNames :equaled => variable("arrayFormNames", "array")
    Orientation :equaled => variable("valOrientation", :"APSpoolerNET.Orientation")
    PaperSizes :equaled => variable("arrayPaperSizes", "array")
    PrinterName :equaled => variable("valPrinterName")
    TrueTypeOption :equaled => variable("valTrueType", :"APSpoolerNET.TrueTypeOptions")
  end
  br

  comment "Use the PrintJobProfile object to set specific printer settings"
  comment "for the print job if the default options are not what is needed."
  PrintJobProfile "SettingsOne", :release_net => false, :object => "oPJP", :class => "APSpoolerNET.PrinterProfile" do
    br
    BinSource :equals => 15
    Collate :equals => false
    ColorMode :equals => {:com => 2, :net => "Color", :enum => "ColorMode"}
    DPI :equals => 300
    Duplex :equals => {:com => 1, :net => "Simplex", :enum => "DuplexMode"}
    FormName :equals => "SampleForm"
    Nup :equals => 0
    Orientation :equals => {:com => 1, :net => "Portrait", :enum => "Orientation"}
    PaperSize :equals => {:com => 1, :net => "Letter", :enum => "PaperSize"}
    PrinterName :equals => "Microsoft Print to PDF"
    PrintOddEvenAll :equals => {:com => 3, :net => "AllPages", :enum => "PrintPages"}
    ProfileName :equals => "SettingsOne"
    Scaling :equals => {:com => 1, :net => "Custom", :enum => "PrintScaling"}
    CustomScaling :equals => 95.0
    TrueTypeOption :equals => {:com => 3, :net => "Substitute", :enum => "TrueTypeOptions"}
    br

    comment "File specific settings"
    @object_name.Copies :equals => 1
    @object_name.PageRange :equals => "1-2,4"
    @object_name.PrintAnnotations :equals => true
    br
    
    # Print function
    case @language_type
    when :net
      comment "Print a PDF"
      if @custom
        @object_name.PrintFile :"oPJP", relative_file("5pageLI.pdf"), :assert_result => "Spooler"
      else
        @object_name.PrintFile @printer, relative_file("5pageLI.pdf"), :assert_result => "Spooler"
      end
    when :com
      if @custom
        comment "Print directly to a printer. Leave first parameter blank for default printer"
        @object_name.PrintFileCustom :"oPJP", relative_file("5pageLI.pdf"), "", :assert_result => ""
      else
        comment "Print directly to a printer. Leave first parameter blank for default printer"
        @object_name.PrintFile @printer, relative_file("5pageLI.pdf"), "", :assert_result => ""
      end
    end

  end
end