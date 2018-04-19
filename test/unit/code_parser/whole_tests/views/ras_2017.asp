<!-- Copyright (c) 2000 ActivePDF, Inc. -->
<!-- ActivePDF Rasterizer 2017 -->
<!-- Example generated 01/01/2000  -->

<%%
Dim strPath, pageCount, currentPage

strPath = Server.MapPath(".") & "\"

' Instantiate Object
Set objVAR = Server.CreateObject("APProduct.Object")

' Open PDF
objVAR.OpenFile strPath & "doc.pdf"

' Get page count of open file
pageCount = objVAR.NumPages()

For currentPage = 1 To pageCount
  ' Image Format
  ' 1 = RGB
  ' 2 = JPEG
  ' 3 = TIFF
  ' 4 = PNG
  ' 5 = BMP
  objVAR.ImageFormat = 2
  
  ' Output Type
  ' 1 = Stream
  ' 2 = File
  objVAR.OutputFormat = 2
  
  ' Other settings
  objVAR.OutputFileName = strPath & "doc" & currentPage & ".jpg"
  objVAR.JPEGQuality = 72
  objVAR.IncludeAnnotations = true
  
  ' Render the current page
  objVAR.RenderPage currentPage
Next

' Finished rendering pages, close file
objVAR.CloseFile 

' Release Object
Set objVAR = Nothing

' Process Complete
Response.Write "Done!"

%>