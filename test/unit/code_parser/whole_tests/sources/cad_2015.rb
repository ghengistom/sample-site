with_dc do |dc|
  comment "Settings specific to CAD conversions"
  createobject "oCAD", :com => "CADConverter.Object", :class => "APDocConverter.CADConverter.CADConverter", :call => "APDocConverter.CADConverter.CADConverter()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.CAD.Net35.dll" do
    br
    comment "Options available for CAD conversions"
    if @language_type == :net
      comment "Options that are 'NotSet' use the setting from the configuation manager"
      ASCIIHexEncoding :equals => false
      Color :equals => :"APDocConverter.CADConverter.ColorMode.NotSet"
      EmbedFonts :equals => :"APDocConverter.CADConverter.EmbedFontsOptions.NotSet"
      ExportLayers :equals => :"APDocConverter.CADConverter.LayersOptions.NotSet"
      ExportLayouts :equals => :"APDocConverter.CADConverter.LayoutsOptions.NotSet"
      FlateCompression :equals => false
      HatchToBitmapDPI :equals => 150
      HiddenLineRemoval :equals => false
      Lineweight :equals => :"APDocConverter.CADConverter.LineweightOptions.NotSet"
      OtherHatchesSettings :equals => :"APDocConverter.CADConverter.OtherHatchOptions.NotSet"
      PlotStyleTableName :equals => ""
      SHXTextAsGeometry :equals => false
      SimpleGeometryOptimization :equals => false
      SolidHatchesSettings :equals => :"APDocConverter.CADConverter.SolidHatchOptions.NotSet"
      TrueTypeAsGeometry :equals => false
      ZoomToExtents :equals => true
    else
      ASCIIHexEncoding :equals => false
      Color :equals => 0
      EmbedFonts :equals => 2
      ExportLayers :equals => 2
      ExportLayouts :equals => 0
      FlateCompression :equals => false
      HatchToBitmapDPI :equals => 150
      HiddenLineRemoval :equals => false
      Lineweight :equals => -1
      OtherHatchesSettings :equals => 0
      PlotStyleTableName :equals => ""
      SHXTextAsGeometry :equals => false
      SimpleGeometryOptimization :equals => false
      SolidHatchesSettings :equals => 2
      TrueTypeAsGeometry :equals => false
      ZoomToExtents :equals => true
    end
    br
    comment "Page size is only set if ZoomToExtents is true"
    SetExtentsPageSize 210, 297
    br
    comment "Convert the settings to XML and send it to DocConverter"
    Serialize(:var => variable("cadXML", "string"))
    dc.SetAddonOptions variable("cadXML")
  end
  br
  @file_doc = "sample.dwg"
  @outfile = "new.pdf"
  comment "Convert the file to PDF"
  comment :net => "If the output parameter is not used the created PDF will use"
  comment :net => "the input string substituting the filename extension to 'pdf'"
  ConvertToPDF relative_file(@file_doc), relative_file(@outfile), :assert_result => "DocConverter"
end