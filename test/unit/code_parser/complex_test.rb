class ComplexTests < CodeParserTest
  def setup
    super
    FactoryGirl.create(:category, :id => 5)
    1.upto(9).each {|n| FactoryGirl.create(:snippet, :id => n, :category_id => 5)}
    FactoryGirl.create(:snippet, :id => 10, :code => 'with_tk do; asdf :equals => @test; end', :category_id => 5)
  end
  
  def test_nested_products
    @languages.each do |lang|
      lang[:parser].with_dc do |dc|
        dc.test :equals => "asdf"
        lang[:parser].with_tk do |tk|
          tk.test :equals => "asdf"
        end
      end
      
      expected_string = case lang[:parser]
      when PHP::Code
        "$oDC->test = \"asdf\";"
      when VB::Code, VBS::Code, Ruby::Code
        "oDC.test = \"asdf\""
      when CF::Code
        "oDC.Set_test(\"asdf\");"
      else
        'oDC.test = "asdf";'
      end
      refute_nil lang[:parser].get_output.index{|x| x.index(expected_string) != nil }, lang[:parser]
      
      expected_string = case lang[:parser]
      when PHP::Code
        "$oTK->test = \"asdf\";"
      when VB::Code, VBS::Code, Ruby::Code
        "oTK.test = \"asdf\""
      when CF::Code
        "oTK.Set_test(\"asdf\");"
      else
        'oTK.test = "asdf";'
      end
      refute_nil lang[:parser].get_output.index{|x| x.index(expected_string) != nil }, lang[:parser]
    end
  end
  
  def test_snippet_reservered_words
    @languages.each do |lang|
      lang[:parser].with_tk do |tk|
        assert_raises Generic::UsedReservedVariable, lang[:parser] do
          lang[:parser].snippet(10, :variables => "test", :test => 1234)
        end
      end
    end
  end
  
  def test_snippet
    @languages.each do |lang|
      lang[:parser].with_tk do |tk|
        lang[:parser].snippet(10, :test => 1234)
        @expected_string = lang[:parser].set_property("asdf", 1234)
      end
      
      refute_nil lang[:parser].get_output.flatten.index{|x| x.index(@expected_string)}, lang[:parser]
    end
  end
  
  def test_snippet_categories_and_exclude
    @languages.each do |lang|
      lang[:parser].instance_variable_set(:@snippets_to_use, {"5" => "10"})
      lang[:parser].with_tk do |tk|
        lang[:parser].snippet(10, :test => 1234, :category => true, :exclude => 1)
        @expected_string = lang[:parser].set_property("asdf", 1234)
      end
      
      refute_nil lang[:parser].get_output.flatten.index{|x| x.index(@expected_string)}, lang[:parser]
      assert_equal [5], lang[:parser].snippets, lang[:parser]
      assert_equal [1], lang[:parser].snippets_to_exclude, lang[:parser]
    end
  end
  
  def test_snippet_selection_by_user
    @languages.each do |lang|
      lang[:parser].instance_variable_set(:@snippets_to_use, {5 => 5})
      lang[:parser].with_tk do |tk|
        lang[:parser].snippet(10, :test => 1234, :category => true, :exclude => 1)
        @expected_string = lang[:parser].set_property("asdf", 1234)
      end
      
      assert_nil lang[:parser].get_output.flatten.index{|x| x.index(@expected_string)}, lang[:parser]
      assert_equal [5], lang[:parser].snippets, lang[:parser]
      assert_equal [1], lang[:parser].snippets_to_exclude, lang[:parser]
    end
  end
  
  def test_to_code
    @languages.each do |lang|
      lang[:parser].with_svr do |s|
        lang[:parser].to_code "test", [5]
      end
      
      expected_string = case lang[:parser]
      when PHP::Code
        "$oSVR->test(5);"
      when VB::Code, Ruby::Code
        "oSVR.test(5)"
      when VBS::Code
        "oSVR.test 5"
      else
        'oSVR.test(5);'
      end
      refute_nil lang[:parser].get_output.flatten.index("#{lang[:parser].indents.spaces}#{expected_string}"), lang[:parser]
    end
  end
  
end