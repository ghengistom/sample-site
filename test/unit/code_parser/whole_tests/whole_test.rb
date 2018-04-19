require 'test_helper'
require_relative '../../../../lib/code_parser/generic_code'
require_relative '../code_parser_test'

class WholeTests < CodeParserTest
  def setup
    # Categories
    # FactoryGirl.create(:category, :id => 101, :name => "Convert to PDF")

    # Snippet accepting variables
    @SnippetCode = <<-END.gsub(/^ {6}/, '')
      comment \"Snippet with variables\"
      comment @stringComment
      @intValue ||= 1
      SetSnippetPropertyToInt :equals => @intValue
      @arrayValues ||= ["Array of numbers and strings", 1, 18.38]
      @arrayValues.each do |asdf|
        ArrayProperty :equals => asdf
      end
      comment @hash.inspect
    END
    FactoryGirl.create(:snippet, :id => 1, :code => @SnippetCode)

    # Category snippets
    # FactoryGirl.create(:snippet, :id => 51, :category_id => 101, :name => "PS to PDF", :code => "comment \"PS to PDF\"")
    # FactoryGirl.create(:snippet, :id => 52, :category_id => 101, :name => "XPS to PDF", :code => "comment \"XPS to PDF\"")
    # FactoryGirl.create(:snippet, :id => 53, :category_id => 101, :name => "Image to PDF", :code => "comment \"Image to PDF\"")
    # FactoryGirl.create(:snippet, :id => 54, :category_id => 101, :name => "PCL to PDF", :code => "comment \"PCL to PDF\"")
    # FactoryGirl.create(:snippet, :id => 55, :category_id => 101, :name => "Pring to PDF", :code => "comment \"Print to PDF\"")
  end
  
  def teardown
    Category.delete_all
    Snippet.delete_all
  end
  
  tests = {}
  Dir[File.dirname(__FILE__) + "/sources/*"].each do |file|
    tests[file] = case File.basename(file, ".rb")
    when "assert_result"
      {
        :product => {:name => "Server", :version => "2012"},
        :example => {:title => "SVR 2012 Test Sample"}
      }
    when "assert_result_manual"
      {
        :product => {:name => "Xtractor", :version => "2015"},
        :example => {:title => "XT 2015 Test Sample"}
      }
    when "createobject"
      {
        :product => {:name => "DocConverter", :version => "2015"},
        :example => {:title => "DC 2015 Test Sample"}
      }
    when "comment_beta"
      {
        :product => {:name => "Toolkit Professional", :version => "2012"},
        :example => {:title => "Comment Beta for active beta products"},
        :version => {:status => "active", :beta => true}
      }
    when "comment_future"
      {
        :product => {:name => "Toolkit Professional", :version => "2012"},
        :example => {:title => "Comment Beta for future products"},
        :version => {:status => "future"}
      }
    when "cad_2015"
      {
        :product => {:name => "CADConverter", :version => "2015"},
        :example => {:title => "CAD 2015 Test Sample"},
        :langs => %w(PHP CS VB VBS ASP Ruby CF PS)
      }
    when "dcw_2010"
      {
        :product => {:name => "DocConverter WBE", :version => "2010"},
        :example => {:title => "DC WBE 2010 Test Sample"}
      }
    when "dc_2010"
      {
        :product => {:name => "DocConverter Enterprise", :version => "2010"},
        :example => {:title => "DCe 2010 Test Sample"}
      }
    when "dc_2014"
      {
        :product => {:name => "DocConverter", :version => "2014"},
        :example => {:title => "DC 2014 Test Sample"}
      }
    when "dc_2015"
      {
        :product => {:name => "DocConverter", :version => "2015"},
        :example => {:title => "DC 2015 Test Sample"},
        :langs => %w(PHP CS VB VBS ASP Ruby CF PS)
      }
    when "mer_2010"
      {
        :product => {:name => "Meridian", :version => "2010"},
        :example => {:title => "MER 2010 Test Sample"}
      }
    when "ocr_2017"
      {
        :product => {:name => "OCR", :version => "2017"},
        :example => {:title => "OCR 2017 Test Sample"},
        :langs => %w(CS VB)
      }
    when "ocr_2017_rest"
      {
        :product => {:name => "OCR", :version => "2017"},
        :example => {:title => "OCR 2017 Test Sample"},
        :langs => %w(CS VB HTML Shell)
      }
    when "portal_2011"
      {
        :product => {:name => "Portal", :version => "2011"},
        :example => {:title => "Portal 2011 Test Sample"},
        :langs => %w(CS VB)
      }
    when "sp_2017"
      {
        :product => {:name => "Spooler", :version => "2017"},
        :example => {:title => "Spooler 2017 Test Sample"}
      }
    when "svr_2009"
      {
        :product => {:name => "Server", :version => "2009"},
        :example => {:title => "SVR 2009 Test Sample"}
      }
    when "svr_2013"
      {
        :product => {:name => "Server", :version => "2013"},
        :example => {:title => "SVR 2013 Test Sample"}
      }
    when "tk_2011"
      {
        :product => {:name => "Toolkit", :version => "2011"},
        :version => {:use_dispose => true},
        :example => {:title => "TK 2011 Test Sample"}
      }
    when "tk_2016"
      {
        :product => {:name => "Toolkit", :version => "2016"},
        :version => {:use_dispose => true, :namespace => "APToolkitNET", :class_name => "Toolkit", :dll_paths => "C:\\Program Files\\ActivePDF\\Toolkit\\DotNetComponent\\2.0\\APToolkitNET.dll"},
        :example => {:title => "TK 2016 Test Sample"}
      }
    when "tk_2017"
      {
        :product => {:name => "Toolkit", :version => "2017"},
        :version => {:use_dispose => true, :namespace => "APToolkitNET", :class_name => "Toolkit", :dll_paths => "C:\\Program Files\\ActivePDF\\Toolkit\\DotNetComponent\\2.0\\APToolkitNET.dll"},
        :example => {:title => "TK 2017 Test Sample"}
      }
    when "ras_2017"
      {
        :product => {:name => "Rasterizer", :version => "2017"},
        :version => {:use_dispose => true},
        :example => {:title => "RAS 2017 Test Sample"},
        :langs => %w(PHP CS VB VBS ASP Ruby CF PS)
      }
    when "wgw_2010"
      {
        :product => {:name => "WebGrabber WBE", :version => "2010"},
        :example => {:title => "WG WBE 2010 Test Sample"}
      }
    when "wg_2009"
      {
        :product => {:name => "WebGrabber Enterprise", :version => "2009"},
        :example => {:title => "WGe 2009 Test Sample"}
      }
    when "wg_2013"
      {
        :product => {:name => "WebGrabber", :version => "2016"},
        :example => {:title => "WG 2016 Test Sample"}
      }
    when "wg_2016"
      {
        :product => {:name => "WebGrabber", :version => "2016"},
        :version => {:namespace => "APWebGrabber", :class_name => "WebGrabber", :dll_paths => "C:\\Program Files\\activePDF\\WebGrabber\\bin\\APWebGrabber.Net35.dll"},
        :example => {:title => "WG 2016 Test Sample"}
      }
    when "xt_2015"
      {
        :product => {:name => "Xtractor", :version => "2015"},
        :example => {:title => "XT 2015 Test Sample"},
        :langs => %w(CS VB)
      }
    else
      {
        :product => {:name => "Server", :version => "2009"},
        :example => {:title => "Unknown Test Sample"}

        # :product => {:name => "Toolkit", :version => "2016"},
        # :version => {:namespace => "NameSpace", :class_name => "Class", :dll_paths => "c:\\folder\\path\\file.dll"},
        # :example => {:title => "Testing basic concepts"},
        # :langs => %w(PHP CS VB VBS ASP Ruby CF)
      }
    end

    # Default product values
    tests[file][:product] = Hash.new unless tests[file][:product]
    tests[file][:product][:name] = "Toolkit" unless tests[file][:product] && tests[file][:product][:name]
    tests[file][:product][:version] = "2016" unless tests[file][:product] && tests[file][:product][:version]

    # Default version values
    tests[file][:version] = Hash.new unless tests[file][:version]
    tests[file][:version][:dll_paths] = "c:\\folder\\path\\file.dll" unless tests[file][:version] && tests[file][:version][:dll_paths]
    tests[file][:version][:namespace] = "NameSpace" unless tests[file][:version] && tests[file][:version][:namespace]
    tests[file][:version][:class_name] = "Class" unless tests[file][:version] && tests[file][:version][:class_name]
    tests[file][:version][:com_object] = "APProduct.Object" unless tests[file][:version] && tests[file][:version][:com_object]
    tests[file][:version][:object_name] = "objVAR" unless tests[file][:version] && tests[file][:version][:object_name]
    tests[file][:version][:use_dispose] = false unless tests[file][:version] && tests[file][:version][:use_dispose]
    
    # Default example values
    tests[file][:example] = Hash.new unless tests[file][:example]
    tests[file][:example][:title] = "Testing basic concepts" unless tests[file][:example] && tests[file][:example][:title]

    # Default langs values
    tests[file][:langs] = %w(PHP CS VB VBS ASP Ruby CF) unless tests[file][:langs]

  end

  `rm -rf #{File.dirname(__FILE__)}/views/diffs/*`
  tests.each do |file, options|
    options[:langs].each do |lang|
      define_method "test_#{file}_#{lang.downcase}".to_sym do
        whole_language lang, file, options
      end
    end
  end
  
  def compare_example_output(actual, expected_file, lang)
    new_file_end = ".new.#{lang.downcase}"
    new_file_end = new_file_end.gsub("ruby", "rb")
    # write a new file from the current output to compare
    actual = actual.gsub(") " + Time.now.strftime("%Y"), ') 2000').gsub(Time.now.strftime("%D"), '01/01/2000')
    File.write("#{expected_file}#{new_file_end}", actual.gsub('<%','<%%'))
    
    # Uncomment out the following line to generate new standards for output code 
    #File.write("#{expected_file}", actual.gsub('<%','<%%'))
    
    expected_output = ERB.new(File.read(expected_file)).result
    
    diff_file = File.dirname(expected_file) + '/diffs/' +  File.basename(expected_file) + '.diff'
    `diff --unified=10 #{expected_file} #{expected_file}#{new_file_end} > #{diff_file}` unless expected_output == actual
    
    # erase file created
    if expected_output == actual
      File.delete "#{expected_file}#{new_file_end}"
    end
    
    assert_equal expected_output, actual, lang
  end
  
  def whole_language(lang, file, options)
    code = File.read(file)
    test_filename = File.dirname(__FILE__) + "/views/#{File.basename(file, ".rb")}.#{lang.downcase}"
    test_filename = test_filename.gsub("ruby", "rb")
    output = Kernel.const_get(lang).const_get("Code").send(:parse, code, options).dump

    compare_example_output output[:code], test_filename, lang
    
    if output.has_key?(:portal_aspx)
      compare_example_output output[:portal_aspx], File.dirname(test_filename) + "/#{File.basename(file, ".rb")}.#{lang.downcase}.aspx", lang
    end

    assert_equal Array.new, output[:snippets], lang
    if File.basename(file) == "source.rb"
      assert_equal [1], output[:snippets_in_use], lang
      assert_equal Array.new, output[:snippets_to_exclude], lang
      assert_equal Hash.new, output[:snippets_to_use], lang
      assert_equal ["asdf.pdf", "new.pdf", "PDF.pdf", "BMP.bmp", "JPEG.jpg", "TIFF.tif"], output[:files], lang
    end
  end
end