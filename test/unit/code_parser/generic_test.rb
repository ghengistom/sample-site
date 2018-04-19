class GenericTests < CodeParserTest
  def test_br
    @languages.each do |lang|
      lang[:parser].br
      lang[:parser].br
      lang[:parser].br
      
      assert_equal nil, lang[:parser].br, lang[:parser]
      
      lang[:parser].get_output.each do |line|
        assert_equal "", line.strip, lang[:parser]
      end
      assert_equal 4, lang[:parser].get_output.length, lang[:parser]
    end
  end
  
  def test__comment
    @languages.each do |lang|
      comment = "This is a comment"
      assert_equal "#{lang[:comment_symbol]}#{comment}", lang[:parser]._comment(comment), lang[:parser]
    end
  end
  
  def test_comment
    @languages.each do |lang|
      comment = "This is a comment"
      assert_equal nil, lang[:parser].comment(comment), lang[:parser]
      assert_match "#{lang[:comment_symbol]}#{comment}", lang[:parser].dump[:code], lang[:parser]
    end
  end
  
  def test_quoted
    @languages.each do |lang|
      assert_equal '"asdf"', lang[:parser].instance_eval("\"asdf\".quoted"), lang[:parser]
      assert_equal :asdf, lang[:parser].instance_eval(":asdf.quoted"), lang[:parser]
      assert_equal true, lang[:parser].instance_eval("true.quoted"), lang[:parser]
      assert_equal false, lang[:parser].instance_eval("false.quoted"), lang[:parser]
      assert_equal 122, lang[:parser].instance_eval("122.quoted"), lang[:parser]
      float = case lang[:parse]
      when CS::Code
        "1.2f"
      else
        1.2
      end
      assert_equal float, lang[:parser].instance_eval("(1.2).quoted"), lang[:parser]
    end
  end
  
  def test_array_to_quoted_strings
    array = ["This", "is","my","array", 123, :asdfasdf]
    @languages.each do |lang|
      assert_equal ["\"This\"", "\"is\"", "\"my\"", "\"array\"", 123, :asdfasdf], lang[:parser].array_to_quoted_strings(array)
    end
  end
  
  def test_add_indents
    string = "This is a test"
    @languages.each do |lang|
      (1..10).each do |number|
        assert_equal "#{lang[:parser].indents.spaces}This is a test", lang[:parser].add_indents(string)
      end
    end
  end
  
  def test_relative_file
    string = "Testing.pdf"
    @languages.each do |lang|
      symbol = case lang[:parser]
      when PHP::Code
        :$strPath
      else
        :strPath
      end
      symbol_line = case lang[:parser]
      when PHP::Code
        :"$strPath . \"Testing.pdf\""
      else
        "strPath #{lang[:parser].concat_symbol} \"Testing.pdf\"".to_sym
      end
      assert_equal symbol, lang[:parser].relative_file("")
      assert_equal symbol_line, lang[:parser].relative_file(string)
      assert_equal ["", "Testing.pdf"], lang[:parser].files
    end
  end
  
  def test_with_products
    @languages.each do |lang|
      assert_includes lang[:parser].methods, :with_svr
      lang[:parser].with_svr do |s|
        s.Test "asdf"
      end
      assert_match 'Test', lang[:parser].dump[:code]
      assert_match '"asdf"', lang[:parser].dump[:code]
    end
  end
  
  def test_output
    string = "this is my output"
    @languages.each do |lang|
      initial_indents = lang[:parser].indents
      
      # test without any options
      lang[:parser].output(string)
      test_array = ["#{initial_indents.spaces}#{string}"]
      assert_equal test_array, lang[:parser].get_output
      
      # test with :indents option
      lang[:parser].output(string, :indents => 12)
      test_array << "#{12.spaces}#{string}"
      assert_equal test_array, lang[:parser].get_output
      assert_equal initial_indents, lang[:parser].indents
      
      # test with :insert option
      lang[:parser].output(string, :insert => 0, :indents => 3)
      test_array.insert(0, "#{3.spaces}#{string}")
      assert_equal test_array, lang[:parser].get_output
    end
  end
  
  def test_method_with_no_args
    @languages.each do |lang|
      expected_string = case lang[:parser]
      when PHP::Code
        "$oSVR->asdf();"
      when VB::Code
        "oSVR.asdf()"
      when VBS::Code
        "oSVR.asdf "
      when Ruby::Code
        "oSVR.asdf()"
      else
        "oSVR.asdf();"
      end
      lang[:parser].with_svr do |s|
        assert_equal expected_string, s.method("asdf",[]), lang[:parser]
      end
    end
  end
  
  def test_method_with_args
    @languages.each do |lang|
      expected_string = case lang[:parser]
      when PHP::Code
        "$oSVR->asdf(\"file\", 3, test, true, false);"
      when VB::Code, Ruby::Code
        "oSVR.asdf(\"file\", 3, test, true, false)"
      when VBS::Code
        "oSVR.asdf \"file\", 3, test, true, false"
      else
        "oSVR.asdf(\"file\", 3, test, true, false);"
      end
      lang[:parser].with_svr do |s|
        assert_equal expected_string, s.method("asdf", ["file", 3, :test, true, false]), lang[:parser]
      end
    end
  end
  
  def test_error
    @languages.each do |lang|
      expected_string = case lang[:parser]
      when PHP::Code
        "Error(\"Asdf\", $variable);"
      when VB::Code
        "ErrorHandler(\"Asdf\", variable)"
      when VBS::Code
        "ErrorHandler \"Asdf\", variable"
      when Ruby::Code
        "puts \"Error in Asdf: \#{variable}\""
      when CS::Code
        "ErrorHandler(\"Asdf\", variable);"
      else
        "Error(\"Asdf\", variable);"
      end
      lang[:parser].with_svr do |s|
        assert_equal expected_string, s._error("Asdf", lang[:parser].get_variable_name("variable"), {}), lang[:parser]
      end
    end
  end
  
  def test_set_property
    @languages.each do |lang|
      ["variable", 1, :test_asdf, true, false].each do |var|
        expected_string = case lang[:parser]
        when PHP::Code
          "$oSVR->Asdf = #{var};"
        when VB::Code, VBS::Code, Ruby::Code
          "oSVR.Asdf = #{var}"
        when CF::Code
          "oSVR.Set_Asdf(#{var});"
        else
          "oSVR.Asdf = #{var};"
        end
        lang[:parser].with_svr do |s|
          assert_equal expected_string, s.set_property("Asdf", var), lang[:parser]
        end
      end
    end
  end
  
  def test_get_property_without_append
    @languages.each do |lang|
      expected_string = case lang[:parser]
      when PHP::Code
        "$variable = $oSVR->Asdf;"
      when VB::Code, VBS::Code, Ruby::Code
        "variable = oSVR.Asdf"
      when CF::Code
         "variable = oSVR.Get_Asdf();"
      else
        "variable = oSVR.Asdf;"
      end
      lang[:parser].with_svr do |s|
        assert_equal expected_string, s.get_property("Asdf", lang[:parser].get_variable_name("variable")), lang[:parser]
      end
      lang[:parser].with_wgw do |s|
        assert_equal expected_string.gsub("oSVR", "oWGw"), s.get_property("Asdf", lang[:parser].get_variable_name("variable")), lang[:parser]
      end
    end
  end
  
  def test_get_property_with_append
    @languages.each do |lang|
      ["variable", 1, :test_asdf].each do |var|
        expected_string = case lang[:parser]
        when PHP::Code
          "$variable = $oSVR->Asdf #{lang[:parser].concat_symbol} #{var.quoted};"
        when VB::Code, VBS::Code, Ruby::Code
          "variable = oSVR.Asdf #{lang[:parser].concat_symbol} #{var.quoted}"
        when CF::Code
          "variable = oSVR.Get_Asdf #{lang[:parser].concat_symbol} #{var.quoted};"
        else
          "variable = oSVR.Asdf #{lang[:parser].concat_symbol} #{var.quoted};"
        end
        lang[:parser].with_svr do |s|
          assert_equal expected_string, s.get_property("Asdf", lang[:parser].get_variable_name("variable"), var), lang[:parser]
        end
      end
    end
  end
  
  def test_assign_variable_from_method
    @languages.each do |lang|
      ["variable", 1, :test_asdf].each do |var|
        expected_string = case lang[:parser]
        when PHP::Code
          "$variable = $oSVR->method(1, \"two\", three);"
        when VB::Code, VBS::Code, Ruby::Code
          "variable = oSVR.method(1, \"two\", three)"
        else
          "variable = oSVR.method(1, \"two\", three);"
        end
        lang[:parser].with_svr do |s|
          assert_equal expected_string, s.assign_variable_from_method(lang[:parser].get_variable_name("variable"), "method", [1, "two", :three]), lang[:parser]
        end
      end
    end
  end
  
  def test_with_product_variables
    @languages.each do |lang|
      @products.each do |name|
        # use different types of variables being passed to the with_product method
        tests = [{:test => "asdf"}]
        tests.each do |test|
          lang[:parser].send("with_#{name}".to_sym, test) do
            assert_equal test, lang[:parser].instance_variable_get("@#{name}_options")
          end
        end
      end
    end
  end
  
  def test_concat
    @languages.each do |lang|
      expected_string = case lang[:parser]
      when PHP::Code
        '"asdf" . "2344"'.to_sym
      when VB::Code, VBS::Code, CF::Code
        '"asdf" & "2344"'.to_sym
      else
        '"asdf" + "2344"'.to_sym
      end
      assert_equal expected_string, lang[:parser].concat("asdf","2344"), lang[:parser]
    end
  end
  
end