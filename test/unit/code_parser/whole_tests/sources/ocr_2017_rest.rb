# New for OCR 2017
# REST API, added HTML and SHELL languages.


# Example specific default variables
@URL = "http://localhost:62625/api/OCR/Conversion"
@InputFile = "multipage.tif"
@OutputFile = "new.pdf"

@OptionName1 = "OCRType"
@OptionValue1 = "0"

@OptionName2 = "PictureHandling"
@OptionValue2 = "1"

@OptionName3 = "PDFVersion"
@OptionValue3 = "4"

@OptionName4 = "Linearize"
@OptionValue4 = "1"

# Example specific default variables
@URL ||= "<<insert url>>"
@InputFile ||= "<<insert input file>>"
@OutputFile ||= "<<insert output file>>"
@Token ||= "<<insert token here>>"

@OptionName1 ||= "<<insert option name>>"
@OptionValue1 ||= "<<insert option value>>"

@OptionName2 ||= "<<insert option name>>"
@OptionValue2 ||= "<<insert option value>>"

@OptionName3 ||= "<<insert option name>>"
@OptionValue3 ||= "<<insert option value>>"

@OptionName4 ||= "<<insert option name>>"
@OptionValue4 ||= "<<insert option value>>"


# Required Imports/Using
imports "System.IO"
imports "System.Net"
imports "System.Net.Http"
imports "System.Net.Http.Headers"

if @language == "cs"
	imports "System.Threading.Tasks"
end

# C#
cs_c = <<END
Task.Run(async () =>
{
    string Folder = AppDomain.CurrentDomain.BaseDirectory;
    string Result = string.Empty;
    string InputFile = Folder + "#{@InputFile}";
    string OutputFile = Folder + "#{@OutputFile}";

    using (HttpClient client = new HttpClient())
    {
        string token = string.Empty;

        Uri uri = new Uri("#{@URL}");

        // Set the Access Token for authorization
        token = "#{@Token}";
        AuthenticationHeaderValue ahv = new AuthenticationHeaderValue("Bearer", token);
        client.DefaultRequestHeaders.Authorization = ahv;

        // Multipart form post
        MultipartFormDataContent content = new MultipartFormDataContent();

        // Input file as a file stream
        FileStream fs = File.OpenRead(InputFile);
        StreamContent streamContent = new StreamContent(fs);
        streamContent.Headers.Add("Content-Type", "application/octet-stream");
        streamContent.Headers.Add("Content-Disposition", @"form-data; name=""InputFile""; filename=""" + Path.GetFileName(InputFile) + @"""");
        content.Add(streamContent, InputFile, Path.GetFileName(InputFile));

        // Each setting can be passed in here as a new StringContent
        content.Add(new StringContent("#{@OptionValue1}"), "#{@OptionName1}");
        content.Add(new StringContent("#{@OptionValue2}"), "#{@OptionName2}");
        content.Add(new StringContent("#{@OptionValue3}"), "#{@OptionName3}");
        content.Add(new StringContent("#{@OptionValue4}"), "#{@OptionName4}");

        // Post the content to the endpoint (uri)
        HttpResponseMessage hrm = await client.PostAsync(uri, content);
        if (hrm.StatusCode == HttpStatusCode.OK)
        {
            // Get the resulting output of the post
            byte[] bytes = await hrm.Content.ReadAsByteArrayAsync();
            // Specify where you want the PDF to save
            File.WriteAllBytes(OutputFile, bytes);
        }
        else
        {
            // Get the error message if something went wrong
            string error = await hrm.Content.ReadAsStringAsync();
            WriteResults(error);
        }
    }
}).Wait();
END

# VB.NET
vb_c = <<END
Dim Folder As String = AppDomain.CurrentDomain.BaseDirectory
Dim InputFile As String = Folder + "#{@InputFile}"
Dim OutputFile As String = Folder + "#{@OutputFile}"
Dim result As String = String.Empty

Using client As New HttpClient()
    Dim token As String = String.Empty
    Dim uri As New Uri("#{@URL}")

    ' Set the Access Token for authorization
    token = "#{@Token}"
    Dim ahv As New AuthenticationHeaderValue("Bearer", token)
    client.DefaultRequestHeaders.Authorization = ahv

    ' Multipart form post
    Dim content As New MultipartFormDataContent()

    ' Input file as a file stream
    Dim fs As FileStream = File.OpenRead(InputFile)
    Dim streamContent As New StreamContent(fs)
    streamContent.Headers.Add("Content-Type", "application/octet-stream")
    streamContent.Headers.Add("Content-Disposition", "form-data; name=""InputFile""; filename=""" + Path.GetFileName(InputFile) + """")
    content.Add(streamContent, "InputFile", Path.GetFileName(InputFile))

    ' Each setting can be passed in here as a new StringContent
    content.Add(New StringContent("#{@OptionValue1}"), "#{@OptionName1}")
    content.Add(New StringContent("#{@OptionValue2}"), "#{@OptionName2}")
    content.Add(New StringContent("#{@OptionValue3}"), "#{@OptionName3}")
    content.Add(New StringContent("#{@OptionValue4}"), "#{@OptionName4}")

    ' Post the content to the endpoint (uri)
    Dim hrm As HttpResponseMessage = client.PostAsync(uri, content).Result
    If hrm.StatusCode = HttpStatusCode.OK Then
        ' Get the resulting output of the post which is the PDF file created with OCR
        Dim bytes As Byte() = hrm.Content.ReadAsByteArrayAsync().Result

        ' Specify where to save the PDF
        File.WriteAllBytes(OutputFile, bytes)
    Else
        ' Get the error message if something went wrong
        Dim errorMsg As String = hrm.Content.ReadAsStringAsync().Result
        WriteResults(errorMsg)
    End If
End Using
END

# Ruby
rb_c = <<END
require 'net/https'
require 'net/http/post/multipart'
require 'json'

# Get current path
strPath = File.expand_path(File.dirname(__FILE__)) + "\\"

token = "#{@Token}"
endpoint = "#{@URL}"
input_file = strPath + "#{@InputFile}"
output_file = strPath + "#{@OutputFile}"

uri = URI(endpoint)

Net::HTTP.start(uri.host, uri.port, :use_ssl => false) do |http|
  request = Net::HTTP::Post::Multipart.new(
    uri.request_uri,
    'InputFile' => UploadIO.new(input_file, "image/tiff"),
    'OutputFile' => output_file
  )
  request.basic_auth(token, '')

  response = http.request(request)
  puts JSON.parse(response.body)
end

# Process Complete
puts "Done!"
END

# Shell
shell_c = <<END
# Using curl
curl #{@URL} -F "InputFile=@C:\\folder\\#{@InputFile}" -F  "OutputFile=#{@InputFile}" -F "#{@OptionName1}=#{@OptionValue1}" -F "#{@OptionName2}=#{@OptionValue2}" -F "#{@OptionName3}=#{@OptionValue3}" -F "#{@OptionName4}=#{@OptionValue4}" -L -O -J
END

# HTML
html_c = <<END
<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8" />
  <title>ActivePDF Example</title>
</head>
<body>
  <form name="uploadForm" method="POST" enctype="multipart/form-data" action="#{@URL}">
    <h2>Files</h2>
    <div>
      <label>Input File
        <input name="InputFile" type="file" />
      </label>
    </div>
    <div>
      <label>Output Filename
        <input name="OutputFile" type="text" />
      </label>
    </div>
    <h2>OCR Settings</h2>
    <div>
      <label>OCR Type
        <select name="OCRType">
          <option value="0">ImageOnText PDF</option>
          <option value="1">Full OCR</option>
        </select>
      </label>
    </div>
    <div>
      <label>Languages
         <input name="Languages" type="text" />
      </label>
    </div>
    <div>
      <label>Retain Line Numbering
        <input type="radio" name="RetainLineNumbering" value="1" />True
        <input type="radio" name="RetainLineNumbering" value="0" checked/>False
      </label>
    </div>
    <div>
      <label>Picture Handling
        <select name="PictureHandling">
          <option value="0">None</option>
          <option value="1">Original DPI</option>
          <option value="2">DPI 72</option>
          <option value="3">DPI 100</option>
          <option value="4">DPI 150</option>
          <option value="5">DPI 200</option>
          <option value="6">DPI 300</option>
        </select>
      </label>
    </div>
    <div>
      <label>Deskew
        <select name="Deskew">
          <option value="0">Disabled</option>
          <option value="1">Auto 2D</option>
        </select>
      </label>
    </div>
    <div>
      Despeckle Enabled
      <label><input type="radio" name="DespeckleEnabled" value="1" />True</label>
      <label><input type="radio" name="DespeckleEnabled" value="0" checked/>False</label>
    </div>
    <div>
      Auto Rotation
      <label><input type="radio" name="Rotation" value="1" checked />True</label>
      <label><input type="radio" name="Rotation" value="0" />False</label>
    </div>
    <h2>PDF Settings</h2>
    <div>
      <label>PDF Version
        <select name="PDFVersion">
          <option value="-2">1.2</option>
          <option value="0">1.3</option>
          <option value="1">1.4</option>
          <option value="2">1.5</option>
          <option value="3">1.6</option>
          <option value="4">1.7</option>
        </select>
      </label>
    </div>
    <div>
      Linearize
      <label><input type="radio" name="Linearize" value="1" />True</label>
      <label><input type="radio" name="Linearize" value="0" checked/>False</label>
    </div>
    <h3>Metadata</h3>
    <div>
      <label>Title
        <input name="MetadataTitle" type="text" />
      </label>
    </div>
    <div>
      <label>Author
        <input name="MetadataAuthor" type="text" />
      </label>
    </div>
    <div>
      <label>Keywords
        <input id="keywords" name="MetadataKeywords" type="text" />
      </label>
    </div>
    <div>
      <label>Subject
        <input id="subject" name="MetadataSubject" type="text" />
      </label>
    </div>
    <h3>Compression</h3>
    <div>
      Use compression for Text and Line Art<br/>
      <label><input type="radio" name="CompForContents" value="1" checked/>True</label>
      <label><input type="radio" name="CompForContents" value="0" />False</label>
    </div>
    <div>
      Use compression for Embedded Files<br/>
      <label><input type="radio" name="CompForTTF" value="1" checked />True</label>
      <label><input type="radio" name="CompForTTF" value="0" />False</label>
    </div>
    <div>
      Use Flate compression for content streams<br/>
      <label><input type="radio" name="UseFlate" value="1" checked />True</label>
      <label><input type="radio" name="UseFlate" value="0" />False</label>
    </div>
    <div>
      Use JBIG2 compression for B/W images, otherwise it uses TIFF G4. JBIG2 can be used in PDF v1.5 or higher<br/>
      <label><input type="radio" name="UseJBIG2" value="1" checked />True</label>
      <label><input type="radio" name="UseJBIG2" value="0" />False</label>
    </div>
    <div>
      Use JPEG2000 compression for color and grayscale images, otherwise it uses JPEG. JPEG2000 can be used in PDF v1.5 or higher<br/>
      <label><input type="radio" name="UseJPEG2000" value="1" checked />True</label>
      <label><input type="radio" name="UseJPEG2000" value="0" />False</label>
    </div>
    <div>
      Use LZW compression. Set Flate to False to use LZW compression<br/>
      <label><input type="radio" name="UseLZWInsteadOfFlate" value="1" />True</label>
      <label><input type="radio" name="UseLZWInsteadOfFlate" value="0" checked/>False</label>
    </div>
    <div>
      <label>MRC Compression
        <select name="UseMRC">
          <option value="0">Disabled</option>
          <option value="1">Minimal</option>
          <option value="2">Good</option>
          <option value="3">Lossless</option>
        </select>
      </label>
    </div>
    <h3>Encryption</h3>
    <div>
      <label>Enable Security
        <input type="checkbox" name="SecurityUse" value="1"/>
      </label>
    </div>
    <div>
      <label>Security Encryption
        <select name="SecurityEncryption">
          <option value="-1">None</option>
          <option value="2">40-bit</option>
          <option value="3">128-bit</option>
          <option value="4">128-bit AES</option>
          <option value="5">256-bit AES</option>
        </select>
      </label>
    </div>
    <div>
      <label>Owner Password
        <input name="SecurityOwnerPassword" type="text" />
      </label>
    </div>
    <div>
      <label>User Password
        <input name="SecurityUserPassword" type="text" />
      </label>
    </div>
    <div>
      Can Print
      <label><input type="radio" name="SecurityCanPrint" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanPrint" value="0" />False</label>
    </div>
    <div>
      Can Edit
      <label><input type="radio" name="SecurityCanEdit" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanEdit" value="0" />False</label>
    </div>
    <div>
      Can Copy
      <label><input type="radio" name="SecurityCanCopy" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanCopy" value="0" />False</label>
    </div>
    <div>
      Can Annotate
      <label><input type="radio" name="SecurityCanAnnotate" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanAnnotate" value="0" />False</label>
    </div>
    <div>
      Can Fill In Form Fields
      <label><input type="radio" name="SecurityCanFillInFormFields" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanFillInFormFields" value="0" />False</label>
    </div>
    <div>
      Can extract text and graphics
      <label><input type="radio" name="SecurityCanMakeAccessible" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanMakeAccessible" value="0" />False</label>
    </div>
    <div>
      Can Assemble
      <label><input type="radio" name="SecurityCanAssemble" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanAssemble" value="0" />False</label>
    </div>
    <div>
      Can Print High Quality
      <label><input type="radio" name="SecurityCanPrintHiResolution" value="1" checked />True</label>
      <label><input type="radio" name="SecurityCanPrintHiResolution" value="0" />False</label>
    </div>
    <br/>
    <br/>
    <div>
      <input type="submit" value="Submit" id="Submit"/>
    </div>
  </form>
</body>
</html>
END

output_for_language :cs => cs_c, :vb => vb_c, :ruby => rb_c, :shell => shell_c, :html => html_c