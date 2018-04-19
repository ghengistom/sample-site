# New to OCR 2017
# Properties and methods that are under other ones. Not sure the name :)
# Ex: oOCR.Settings.OCR.Deskew


with_version do |n|
  imports "OCRData.Enums.ImageProcessing"
  imports "OCRData.Enums.OCR"

  comment "OCR Settings"
  Settings_OCR_Deskew :equals => :"DeskewOptions.Auto2D"
  Settings_OCR_Despeckled :equals => true
  Settings_OCR_ExportBookmarks :equals => false
  Settings_OCR_OCRType :equals => :"OCRTypeOptions.SearchablePDF"
  Settings_OCR_PictureHandling :equals => :"PictureHandlingOptions.Default"
  Settings_OCR_RetainLineNumbering :equals => false
  Settings_OCR_Rotation :equals => :"RotationOptions.Auto"
  Settings_OCR_Languages_Add :"LanguageOptions.English"
  br

  imports "OCRData.Enums.ImageProcessing"
  
  comment "PDF Compression"
  Settings_PDF_Compression_TextAndLineArt :equals => false
  Settings_PDF_Compression_ContentStream :equals => :"ContentStreamOptions.Flate"
  Settings_PDF_Compression_EmbeddedFonts :equals => false
  Settings_PDF_Compression_BWImages :equals => false
  Settings_PDF_Compression_ColorAndGrayImages :equals => false
  Settings_PDF_Compression_MRC :equals => :"MRCOptions.Disabled"
  br

  comment "PDF Metadata"
  Settings_PDF_Metadata_Author :equals => "John Doe"
  Settings_PDF_Metadata_Title :equals => "OCR Example"
  Settings_PDF_Metadata_Subject :equals => "Example"
  Settings_PDF_Metadata_Keywords :equals => "OCR, example, metadata"
  br

  imports "OCRData.Enums.PDF"
  
  comment "PDF Security"
  Settings_PDF_Security_UseSecurity :equals => false
  Settings_PDF_Security_Encryption :equals => :"EncryptionType.AES_256"
  Settings_PDF_Security_OwnerPassword :equals => "ownerPassword"
  Settings_PDF_Security_UserPassword :equals => "userPassword"
  Settings_PDF_Security_CanAnnotate :equals => false
  Settings_PDF_Security_CanAssemble :equals => false
  Settings_PDF_Security_CanCopy :equals => false
  Settings_PDF_Security_CanEdit :equals => false
  Settings_PDF_Security_CanFillInFormFields :equals => false
  Settings_PDF_Security_CanMakeAccessible :equals => false
  Settings_PDF_Security_CanPrint :equals => false
  Settings_PDF_Security_CanPrintHiResolution :equals => false
  br

  imports "OCRData.Enums.PDF"
  imports "ConverterKit.DK.Enums.PDF"

  comment "PDF version"
  Settings_PDF_Version :equals => :"PDFVersion.PDF1_5"
  Settings_PDF_Format :equals => :"PDFOutputFormat.PDF"
  Settings_PDF_PDFACompliance :equals => :"PDFAComplianceLevel.NotSet"
  br

  imports "OCRData.Enums.PDF"
  
  comment "Basic Settings"
  Settings_Debug :equals => true
  Settings_Timeout :equals => 30;
  Settings_PDF_Linearize :equals => false
  Settings_PDF_OverwriteMethod :equals => :"OverwriteMethod.Always"
  br
  comment "Start OCR conversion"
  Convert relative_file("multipage.tif"), relative_file("new.pdf"), :assert_result => "OCR"
end