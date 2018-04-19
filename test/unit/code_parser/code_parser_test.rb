require 'test_helper'
require_relative '../../../lib/code_parser/generic_code'

class CodeParserTest < ActiveSupport::TestCase
  def setup
    @languages = Array.new
    %w(PHP CS VB VBS ASP Ruby CF).each do |l|
      options = {:snippets => {}}
      hash = Hash.new
      hash[:parser] = Kernel.const_get(l).const_get("Code").send(:new, options)
      hash[:name] = l.downcase
      instance_variable_set("@#{l.downcase}".to_sym, hash)
      @languages << instance_variable_get("@#{l.downcase}".to_sym)
    end
        
    @products = %w(svr wg wgw dc dcw tk)
    
    @variable = "Asdf"
    
    @languages.each do |lang|
      # add variable names
      lang[:variable] = case lang[:parser]
      when PHP::Code
        "$#{@variable}"
      else
        @variable
      end
      
      # add comment symbol
      lang[:comment_symbol] = case lang[:parser]
      when VB::Code, VBS::Code, ASP::Code
        "' "
      when Ruby::Code
        '# '
      else
        "// "
      end
      
      var = lang[:parser].instance_variable_get(:@vars)
      var[:product] = {:name => "Default Test Product"}
      lang[:parser].instance_variable_set(:@vars, var)
    end
  end
  
  def teardown
    Snippet.delete_all
    Category.delete_all
  end
  
  Fixnum.class_eval do
    def spaces
      spaces = ""
      self.times{ spaces << "  " }
      spaces
    end
  end
end
