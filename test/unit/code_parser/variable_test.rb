class VariableTest < CodeParserTest
  
  def test_language_variable
    @languages.each do |lang|
      output_to_check = case lang[:parser]
      when PHP::Code
        "php"
      when CS::Code
        "cs"
      when VB::Code
        "vb"
      when ASP::Code
        "asp"
      when VBS::Code
        "vbs"
      when Ruby::Code
        "rb"
      when CF::Code
        "cf"
      end
      
      assert_equal output_to_check, lang[:parser].instance_variable_get("@language")
    end
  end
  
  def test_get_variable_name
    variable_string = "asdf"
    @languages.each do |lang|
      variable_output = case lang[:parser]
      when PHP::Code
        "$asdf"
      else
        "asdf"
      end
      
      assert_equal variable_output, lang[:parser].get_variable_name(variable_string)
    end
  end
  
  def test_get_typed_variable_name
    variable_string = "Asdf"
    @languages.each do |lang|
      ["String", 1, :Test].each do |type|
        output = case type
        when String
          "str#{variable_string}"
        when Integer
          "int#{variable_string}"
        else
          "#{variable_string}"
        end
        assert_equal output, lang[:parser].get_typed_variable_name(variable_string,type)
      end
    end
  end

  def test_variable_without_type
    variable_string = "asdf"
    
    @languages.each do |lang|
      variable_output = case lang[:parser]
      when PHP::Code
        :$asdf
      else
        :asdf
      end
      variables_hash = case lang[:parser]
      when CS::Code, ASP::Code
        {variable_output => "string"}
      when VBS::Code
        {:FSO=>"string", variable_output => "string"}
      when VB::Code
        {variable_output => "String"}
      else
        {variable_output => "string"}
      end
      
      assert_equal(variable_output, lang[:parser].variable(variable_string), lang[:parser])
      assert_equal(variables_hash, lang[:parser].variables, lang[:parser])
    end
  end
  
  def test_variable_with_type
    variable_string = "asdf"
    variable_type = "byte"
    
    @languages.each do |lang|
      variable_output = case lang[:parser]
      when PHP::Code
        :$asdf
      else
        :asdf
      end
      variables_hash = case lang[:parser]
      when CS::Code
        {variable_output => "byte[]"}
      when VB::Code
        {variable_output => "byte"}
      when ASP::Code
        {variable_output => "byte"}
      when VBS::Code
        {:FSO=>"string", variable_output => "byte"}
      else
        {variable_output => "byte"}
      end
      
      assert_equal(variable_output, lang[:parser].variable(variable_string, variable_type), lang[:parser])
      assert_equal(variables_hash, lang[:parser].variables, lang[:parser])
    end
  end
  
  def test_variable_changing_type
    variable_string = "asdf"
    variable_type_1 = "byte"
    variable_type_2 = "string"
    
    @languages.each do |lang|
      
      assert_raises Generic::ChangedVariableDefinition do
        lang[:parser].variable(variable_string, variable_type_1)
        lang[:parser].variable(variable_string, variable_type_2)
      end
      
    end
  end
end
