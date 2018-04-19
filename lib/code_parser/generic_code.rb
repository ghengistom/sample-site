module Generic
  class Error < RuntimeError; end
  class ChangedVariableDefinition < Error; end
  class UsedReservedVariable < Error; end
  class MultipleAssertProperties < Error; end

  class Code
    ReservedVariables = %w(header output get_output footer snippets variables files indents snippets_to_use snippets_to_exclude defaults variable_types variable_prefix_types control_params custom_aspx)
    
    attr_accessor :header, :footer, :snippets, :snippets_to_exclude, :variables, :files, :comment_symbol, :indents, :concat_symbol, :variable_types, :variable_prefix_types, :language_type

    def get_output
      @output
    end
    
    def initialize(options = Hash.new)
      String.class_eval do
        def indent(indents = 0)
          output = ""
          spaces = ""
          1.upto(indents) do
            spaces << "  "
          end
          self.each_line do |line|
            output << "#{spaces}#{line}"
          end
          output
        end
      end
      
      @variable_types = DataTypes::Variables::VARIABLE_TYPES.clone
      @variable_prefix_types = DataTypes::Variables::VARIABLE_PREFIX_TYPES.clone
      
      @language_type = :com
      
      @header = Array.new
      @output = Array.new
      @footer = Array.new
      @snippets = Array.new
      @snippets_in_use = Array.new
      @snippets_shown = Hash.new
      @snippets_defaults = Hash.new
      @variables = Hash.new
      @files = Array.new
      
      @indents = 0
      
      @@error_check = false
      
      quoted_string
      quoted_float
      quoted_bool
      quoted_hash
      quoted_array
      quoted_point_f
      after_initialize
      @snippets_to_use = options[:snippets]
      @snippets_to_exclude = Array.new
      
      # set language defaults
      @concat_symbol = "&"
      @comment_symbol = '// '
      @lt_symbol = '<'
      @gt_symbol = '>'
      @else_symbol = '} else {'
      @object_symbol = '.'
      @property_get_symbol = ''
      @for_control_end_symbol = "}"
      
      @vars = {
        :wg => {:port => 58585},
        :wgw => {:port => 58585},
        :dc => {:port => 58585},
        :dcw => {:port => 58585},
        :mer => {:port => 58585}
      }
      
      @vars[:product] = Hash.new
      @vars[:product] = options[:product]
      
      @vars[:example] = Hash.new
      @vars[:example] = options[:example]
      
      @vars[:version] = Hash.new
      @vars[:version][:status] = options[:version] && options[:version][:status] ? options[:version][:status] : ""
      @vars[:version][:dll_paths] = options[:version] && options[:version][:dll_paths] ? options[:version][:dll_paths] : ""
      @vars[:version][:namespace] = options[:version] && options[:version][:namespace] ? options[:version][:namespace] : ""
      @vars[:version][:class_name] = options[:version] && options[:version][:class_name] ? options[:version][:class_name] : ""
      @vars[:version][:com_object] = options[:version] && options[:version][:com_object] ? options[:version][:com_object] : ""
      @vars[:version][:object_name] = options[:version] && options[:version][:object_name] ? options[:version][:object_name] : ""
      @vars[:version][:use_dispose] = options[:version] && options[:version][:use_dispose] ? options[:version][:use_dispose] : false
      @vars[:version][:beta] = options[:version] && options[:version][:beta] ? options[:version][:beta] : false
      
      @code_file = ""
      @code_aspx = ""
      @custom_aspx = ""
      
      language_init
      
      # puts "Options: #{options.inspect}"
    end
    
    def quoted_string
      String.class_eval do
        def quoted
          '"' + self + '"'
        end
      end
    end
    
    def quoted_float
      Float.class_eval do
        def quoted
          self
        end
      end
    end

    def quoted_bool
      TrueClass.class_eval do
        def quoted
          self
        end
      end

      FalseClass.class_eval do
        def quoted
          self
        end
      end
    end
    
    def quoted_hash
      Hash.class_eval do
        def quoted
          self.inspect
        end
      end
    end

    def quoted_array
      Array.class_eval do
        def quoted
          self.inspect
        end
      end
    end

    def quoted_point_f
      PointF.class_eval do
        def quoted
          "#{x.quoted}, #{y.quoted}"
        end
      end
    end

    def language_class_setup(type)
      self.language_type = type
      
      # quoting a hash means selecting the :com or :net property from the hash and using that
      Hash.class_eval do
        define_method(:quoted) { self[type].quoted }
      end
    end
    
    def after_initialize
      Fixnum.class_eval do
        def quoted
          self
        end
      end

      Symbol.class_eval do
        def quoted
          self
        end
      end
    end
    
    def cast()
      
    end
    
    def dump
      output @code_start, :insert => 0, :indents => 0
      
      if @header.empty?
        output @relative_files_method + "\n", :insert => 1 unless @files.empty?
        output define_variables, :insert => 1 unless @variables.empty?
      else
        @header << "" unless @header.last.empty? # header should always end with an empty line
        output @header, :insert => 0, :indents => 0
        output @relative_files_method + "\n", :insert => 2 unless @files.empty?
        output define_variables, :insert => 2 unless @variables.empty?
      end
      
      output @after_main_code, :insert => -1, :indents => (@indents - 1)
      output errors_method(@@error_check), :insert => -1, :indents => (@indents - 1) if @@error_check
      output write_results_method, :insert => -1, :indents => (@indents - 1) if @vars[:product][:name] != "Portal"
      output @code_end, :insert => -1, :indents => 0
      
      versioninfo = "(beta)" if @vars[:version][:status] == "future" || @vars[:version][:beta]
      copyright_text = [
        "Copyright (c) #{Time.now.strftime("%Y")} #{I18n.t(:activePDF)}, Inc.",
        "",
        "ActivePDF #{@vars[:product][:name]} #{@vars[:product][:version]}",
        "",
        "Example generated #{Time.now.strftime("%D")} #{versioninfo}",
        ""
      ]
      @output.insert(0,copyright(copyright_text))
      
      @code = @output.delete_if{|i| i.nil? }.join("\n").gsub(/\r?\n/, "\r\n")
      
      output = {
        :code => @code,
        :snippets => @snippets.uniq,
        :snippets_in_use => @snippets_in_use.uniq,
        :snippets_to_exclude => @snippets_to_exclude,
        :snippets_to_use => @snippets_shown,
        :snippets_defaults => @snippets_defaults,
        :files => @files.uniq
      }
        
      output[:code_file] = @code_file.insert(0,copyright(copyright_text) + "\n") if @code_file != ""
      output[:code_aspx] = code_aspx(@code_aspx).insert(0,copyright_aspx(copyright_text) + "\n") if @code_aspx != ""
      output[:portal_aspx] = portal_aspx(@vars[:example][:title], @control_params) if @vars[:product][:name] == "Portal"
      
      return output
    end
    
    def copyright(textArray)
      output = ""
      textArray.each do |line|
        if line.empty?
          output << "\n"
        else
          output << _comment(line)
        end
      end
      return output
    end

    def copyright_aspx(textArray)
      output = "<%--\n"
      textArray.each do |line|
        if line.empty?
          output << "\n"
        else
          output << line
        end
      end
      output << "--%>\n"
      return output
    end
    
    def method_missing(method, *args, &block)
      # if block.nil?
      #   # puts method
      # else
      #   yield
      # end
      # puts "#{method} - #{args.inspect}"
      to_code(method, args, block)
    end
    
    def self.parse(string, options = Hash.new)
      dsl = self.new(options)
      dsl.instance_eval(string)
      dsl
    end
    
    def array_to_quoted_strings(array)
      new_array = Array.new
      array.each do |arg|
        if arg.is_a?(Hash)
          if @language_type == :com
            new_array << arg[:com].quoted
          else
            new_array << quoted_enum(arg)
          end
        else
          new_array << arg.quoted
        end
      end
      new_array
    end

    def quoted_enum(enum)
      if enum.has_key?(:namespace)
        namespace = enum[:namespace]
      else
        namespace = @vars[:version][:namespace]
      end
      "#{namespace}.#{enum[:enum]}.#{enum[:net]}"
    end

    def with_version(version = Hash.new, &block)
      options = Hash.new
      options[:com] = @vars[:version][:com_object]
      options[:class] = "#{@vars[:version][:namespace]}.#{@vars[:version][:class_name]}"
      options[:call] = "#{@vars[:version][:namespace]}.#{@vars[:version][:class_name]}()"
      options[:path] = @vars[:version][:dll_paths]
      obj_name = @vars[:version][:object_name]
      options[:release_net] = true
      options[:from_version] = true

      createobject(obj_name, options, &block)
    end

    def createobject(name, options = Hash.new, &block)
      object_name = get_variable_name "#{name}" # set a local variable equal to the variableized string of "oProduct"
      object_variable_previous = @object_variable
      @object_variable = object_name
      options[:from_createobject] = true unless options[:from_version] === true
      start_object object_name, options
      block.call(self.clone)
      if @vars[:version][:use_dispose]
        options[:dispose] = true
      else
        options[:dispose] = false
      end
      with_multi_end(object_name, options) unless options[:release_net] == false && @language_type == :net
      @object_variable = object_variable_previous
    end
    
    def iff(variable, output)
      value = case true
      when output.has_key?(:equals)
        output[:equals]
      when output.has_key?(:not_equals)
        output[:not_equals]
      when output.has_key?(:gt)
        output[:gt]
      when output.has_key?(:lt)
        output[:lt]
      end
      
      switch = case true
      when output.has_key?(:equals)
        @equals_symbol
      when output.has_key?(:not_equals)
        @not_equals_symbol
      when output.has_key?(:gt)
        @gt_symbol
      when output.has_key?(:lt)
        @lt_symbol
      end
      
      output if_control_start(variable,switch,value)
      @indents += 1
      yield
      @indents -= 1
      output "#{@if_end_symbol}"
    end
    
    def elsee
      @indents -= 1
      output "#{@else_symbol}"
      @indents += 1
      yield
    end
    
    def add_indents(input)
      prefix = ""
      1.upto(@indents) do
        prefix << "  "
      end
      
      if input.class == Array
        input.flatten!
        input.collect {|x| prefix + x}
      else
        prefix + input unless input.nil?
      end
    end
    
    def output(data, options = Hash.new)
      if options.has_key?(:indents)
        old_indents = @indents
        @indents = options[:indents]
      end
      
      if options.has_key?(:insert)
        @output.insert options[:insert], add_indents(data)
      else
        @output << add_indents(data)
      end
      
      if options.has_key?(:indents)
        @indents = old_indents
      end
    end
    
    def to_code(method, args, block=nil)
      method = method.to_s.gsub("_", ".").to_sym if @language_type == :net
      # puts method.inspect
      if args.last.class == Hash
        if args.last.has_key?(:equals)
          if args.last[:equals].is_a?(Hash) && args.last[:equals].has_key?(:enum) && @language_type == :net
            assignment = quoted_enum(args.last[:equals])
          else
            assignment = args.last[:equals].quoted
          end
          output set_property(method, assignment)
        elsif args.last.has_key?(:equaled)
          # set a variable equal to this property
          output get_property(method, args.last[:equaled], args.last[:append])
        else
          # This handles methods with one parameter that is enum
          if args.last.has_key?(:enum)
            output method(method,args)
          else
            options = args.pop
            if options.has_key?(:var)
              # this is a method that we need to capture its output into a variable
              output assign_variable_from_method(options[:var],method,args,options)
            elsif options.has_key?(:object)
              # this is a method that we need to capture the output as an object
              object_name = get_variable_name(options[:object])
              output assign_variable_from_method(object_name, method, args, :object => true, :class => options[:class])
              object_variable_previous = @object_variable
              @object_variable = object_name
              block.call(self.clone) if block
              options[:from_createobject] = true
              with_multi_end(object_name, options) unless options[:release_net] == false && @language_type == :net || @vars[:version][:use_dispose] && @language_type == :net
              @object_variable = object_variable_previous
            else
              # this is a method that requires validation
              method_validation method, args, options
            end
          end
        end
      else
        # this is a normal method
        output method(method,args)
      end
    end
    
    def method_validation(method, args, options)
      raise Generic::MultipleAssertProperties, "Can only have one :assert_* property in #{method}" if options[:assert_equal] && options[:assert_lt]
      
      condition_subject = options[:assert_equal] || options[:assert_lt] || options[:assert_gt]
      
      # Store the output variable so that it can be defined.
      options[:variable_name] = get_variable_name get_typed_variable_name(method,condition_subject,options[:assert_equal_type])
      
      assert_equal  method, args, options if options[:assert_equal]
      assert_lt     method, args, options if options[:assert_lt]
      assert_gt     method, args, options if options[:assert_gt]
      assert_result method, args, options if options[:assert_result]
    end
    
    def assert_result(method, args, options)
      # This is the new syntax for 2012+ products (except maybe TK)
      if self.class.method_defined?("#{@object_variable}_assert_result")
        send("#{@object_variable}_assert_result", method, args, options)
      else
        case true
        when @language_type == :com
          compare_to = 0
          variable_class = "fixnum"
        when @language_type == :net
          if self.class == CF::Code
            compare_to = "Success"
          else
            case options[:assert_result]
            when "DocConverter"
              compare_to = "DCDK.Results.#{options[:assert_result]}Status.Success".to_sym
            when "Xtractor"
              compare_to = "XDK.Results.#{options[:assert_result]}Status.Success".to_sym
            else
              compare_to = "#{options[:assert_result]}DK.Results.#{options[:assert_result]}Status.Success".to_sym
            end
          end
          case options[:assert_result]
          when "DocConverter"
            variable_class = "DCDK.Results.#{options[:assert_result]}Result".to_sym
          when "Xtractor"
            variable_class = "XDK.Results.#{options[:assert_result]}Result".to_sym
          else
            variable_class = "#{options[:assert_result]}DK.Results.#{options[:assert_result]}Result".to_sym            
          end
        end
        variable_name = get_variable_name "results"
        
        variable variable_name, variable_class
        output assign_variable_from_method(variable_name, method, args, :object => true)
        output if_control_start(assert_result_if_subject(variable_name, options[:assert_result]),@not_equals_symbol,compare_to)
        error method, variable_name, :assert_result => options[:assert_result], :result_variable => variable_name, :indents => @indents + 1
        output "#{@if_end_symbol}"
      end
    end
    
    def assert_result_if_subject(variable, assert_result)
      "#{variable}#{@object_symbol}#{assert_result}Status"
    end
    
    def assert_equal(method, args, options)
      # Some products have specific ways of handling assert_equal
      # If the method is in place for that prod/lang, then use it
      # Otherwise, use the generic style
      if self.class.method_defined?("#{@object_variable}_assert_equal")
        send("#{@object_variable}_assert_equal", method, args, options)
      else
        variable_class = options[:assert_equal_type] ? options[:assert_equal_type] : options[:assert_equal].class.to_s.downcase
        variable options[:variable_name], variable_class unless options[:assert_equal].class.to_s == "Symbol"
        output assign_variable_from_method(options[:variable_name],method,args)
        output if_control_start(options[:variable_name],@not_equals_symbol,options[:assert_equal])
        error method, options[:variable_name], :indents => @indents + 1
        output "#{@if_end_symbol}"
      end
    end
    
    def assert_lt(method, args, options)
      variable_class = options[:assert_equal_type] ? options[:assert_equal_type] : options[:assert_lt].class.to_s.downcase
      variable options[:variable_name], variable_class unless options[:assert_lt].class.to_s == "Symbol"
      output assign_variable_from_method(options[:variable_name],method,args)
      output if_control_start(options[:variable_name],@lt_symbol,options[:assert_lt])
      error method, options[:variable_name], :indents => @indents + 1
      output "#{@if_end_symbol}"
    end
    
    def assert_gt(method, args, options)
      variable_class = options[:assert_equal_type] ? options[:assert_equal_type] : options[:assert_gt].class.to_s.downcase
      variable options[:variable_name], variable_class unless options[:assert_gt].class.to_s == "Symbol"
      output assign_variable_from_method(options[:variable_name],method,args)
      output if_control_start(options[:variable_name],@gt_symbol,options[:assert_gt])
      error method, options[:variable_name], :indents => @indents + 1
      output "#{@if_end_symbol}"
    end
    
    def get_variable_name(string)
      "#{string}"
    end
    
    # Return the name of a variable named for the value it will contain
    # === Parameters
    # * _variable_name_ = +string+ name of the variable to convert
    # * _input_variable_ = +string+ variable to be stored. this will be used to determine the value type
    def get_typed_variable_name(variable_name, input_value, input_type = nil)
      unless input_type
        input_type = case input_value
        when String
          :string
        when Fixnum
          :int
        else
          nil
        end
      end
      if input_type
        "#{@variable_prefix_types[input_type.to_sym]}#{variable_name}"
      else
        "#{variable_name}"
      end
    end
    
    def _comment(string)
      @comment_symbol + string
    end
    
    def comment(string)
      if string.is_a?(Hash)
        string = string[self.language_type]
      end
      output _comment(string) unless string.nil?
    end
    
    # Insert a blank new line in the output language
    def br
      output ""
    end
    
    def relative_file(string = "")
      @files << string
      unless string.empty?
        "#{variable("strPath")} #{@concat_symbol} #{string.quoted}".to_sym
      else
        "#{variable("strPath")}".to_sym
      end
    end
    
    def variable(string, type = "", equals = nil)
      name = get_variable_name(string)
      type = if type.is_a?(String)
        case type.downcase
        when ""
          @variables.has_key?(name.to_sym) ? @variables[name.to_sym] : @variable_types[:string]
        else
          @variable_types[type.to_sym]
        end
      else
        type
      end

      if @variables.has_key?(name.to_sym) && type != @variables[name.to_sym]
        raise Generic::ChangedVariableDefinition, "You cannot change the definition of #{name} from #{@variables[name.to_sym]}"
      else
        @variables[name.to_sym] = type
      end
      
      if equals
        output set_property name, equals.quoted, true
      end
      
      name.to_sym
    end
    
    def to_s
      "#{self.class} - #{@output}"
    end
    
    def define_variables; end
    
    def errors_sub; end
    
    def errors_method(type); end
    
    # for each product name create the useful methods
    %w(svr wg wgw dc dcw tk tkfio portal xt mer ras var).each do |name|
      # create the with_product_start empty method
      define_method "with_#{name}_start" do |object, options|; end
      
      # create the with_product method
      define_method "with_#{name}", ->(options = Hash.new, &block) {  # this is the "stabby lambda" style syntax
          if name.length > 2 && name[-1].downcase == "w"
            object_name = get_variable_name "o#{name.upcase[0..-2] + name[-1].downcase}"
          else
            object_name = get_variable_name "o#{name.upcase}" # set a local variable equal to the variableized string of "oProduct"
          end
          object_variable_previous = @object_variable
          @object_variable = object_name                       # set the instance variable equal to the variable name. This will be used by the output methods
          send("with_#{name}_start", object_name, options)     # call the with_product_start method
          instance_variable_set "@#{name}_options", options    # setup a variable to hold the options
          block.call(self.clone)                               # execute the code in the block sent to with_productname
          send("with_#{name}_end", object_name) if self.class.method_defined? "with_#{name}_end" # if language has a with_product_end method then use it
          if @vars[:version][:use_dispose]
            options[:dispose] = true
          else
            options[:dispose] = false
          end
          with_multi_end(object_name, options) unless self.class.method_defined? "with_#{name}_end"       # otherwise call the with_multi_end method
          @object_variable = object_variable_previous
       }
    end
    
    def snippet(id, variables = Hash.new)
      variables[:category] = false unless variables[:category] && variables[:category].class == TrueClass
      variables[:exclude] ||= []
      unless variables[:exclude].class == Array
        variables[:exclude] = [variables[:exclude]]
      end
      variables[:exclude].each{|v| @snippets_to_exclude << v }

      if variables[:category]
        @snippets_defaults[Snippet.find(id).category.id] = id
        id = @snippets_to_use[Snippet.find(id).category.id] if @snippets_to_use.has_key?(Snippet.find(id).category.id) && !@snippets_to_exclude.include?(@snippets_to_use[Snippet.find(id).category.id].to_i)
        @snippets_shown[Snippet.find(id).category.id] = id.to_i
      end
      
      variables.each do |n,v|
        if ReservedVariables.include?(n.to_s)
          raise Generic::UsedReservedVariable, "You cannot use the reserved variable name '#{n}' in your call to snippet #{id}."
        else
          eval("@#{n} = #{v.inspect}") 
        end
      end
      
      snippet = Snippet.find_by_id(id)
      @snippets << snippet.category.id if variables[:category]
      @snippets_in_use << id
      eval(snippet.code)
    end
    
    def output_for_language(args = Hash.new)
      code = args[self.class.to_s.split("::").first.downcase.to_sym] || args[:else]
      output code.split("\n") if code
    end
    
    def error(method, variable, options = Hash.new)
      @@error_check = options.has_key?(:assert_result) ? :result : :default
      if options.has_key?(:indents)
        output _error(method, variable, options), :indents => options[:indents]
      else
        output _error(method, variable, options)
      end
    end
    
    def concat(*args)
      args.map{|item| item.quoted}.join(" #{@concat_symbol} ").to_sym
    end
    
    def imports(string); end
    
    def code_file(args = Hash.new)
      code = args[self.class.to_s.split("::").first.downcase.to_sym] || args[:else]
      @code_file = code if code
    end

    def code_aspx(string)
      if @language == "cs" || @language == "vb"
        @code_aspx = string
      else
        @code_aspx = ""
      end
    end

    def portal_aspx(title, control_params)
      output_lang = case self.class.to_s
      when "CS::Code"
        ["C#", "cs"]
      when "VB::Code"
        ["VB", "vb"]
      end
      aspx_prefix =<<END
<%@ Page Language="#{output_lang[0]}" CodeFile="#{title.gsub(" ","_")}.aspx.#{output_lang[1]}" Inherits="Example" \%\>
<%@ Register Assembly="APPortalUI" Namespace="APPortalUI.Web.UI" TagPrefix="apPortalUI" \%\>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>activePDF Portal Sample</title>
</head>
<body>
  <form id="form1" runat="server">
END

aspx_middle_default =<<END
<div>
  <apPortalUI:PdfWebControl id="PdfWebControl1" runat="server" height="600px" width="100%"
    #{control_params} />
</div>
END

aspx_middle = if @custom_aspx.empty?
  aspx_middle_default
else
  @custom_aspx
end
      aspx_postfix =<<END
  </form>
</body>
</html>
END

      return aspx_prefix + aspx_middle.indent(2) + aspx_postfix
    end
    
    def custom_aspx(*args); end

    def switch(var, &block)
      output select_control_start(var)
      @indents += 1
      yield
      @indents -= 1
      output @case_statment_end_symbol
    end

    def casee(equals, &block)
      output case_control_start(equals)
      @indents += 1
      yield
      output @break_control_symbol if @break_control_symbol
      @indents -= 1
      unless @case_option_end_symbol.nil?
        output @case_option_end_symbol
      end
    end

    def default(&block)
      output case_control_default_start
      @indents += 1
      yield
      output @break_control_symbol if @break_control_symbol
      @indents -= 1
      unless @case_option_end_symbol.nil?
        output @case_option_end_symbol
      end
    end

    def forr(variable, _start, _end)
      output for_control_start(variable, _start, _end)
      @indents += 1
      yield
      @indents -= 1
      output @for_control_end_symbol
    end
  end
end

require "#{File.dirname(__FILE__)}/php"
require "#{File.dirname(__FILE__)}/vbs"
require "#{File.dirname(__FILE__)}/asp"
require "#{File.dirname(__FILE__)}/cf"
require "#{File.dirname(__FILE__)}/cs"
require "#{File.dirname(__FILE__)}/vb"
require "#{File.dirname(__FILE__)}/ruby"
require "#{File.dirname(__FILE__)}/shell"
require "#{File.dirname(__FILE__)}/html"
