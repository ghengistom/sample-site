module Ruby
  class Code < Generic::Code
    def language_init
      [:integer, :long, :int].each {|n| @variable_types[n] = "Fixnum"}
      [:boolean, :bool].each {|n| @variable_types[n] = "boolean"}
      
      @code_start = ["require 'win32ole'",""]
      @after_main_code = ["# Process Complete","puts \"Done!\""]
      
      @comment_symbol = "# "
      @concat_symbol = "+"
      @equals_symbol = "=="
      @not_equals_symbol = "!="
      
      @if_end_symbol = "end"
      @else_symbol = "else"
      @case_statment_end_symbol = "end"
      @for_control_end_symbol = "end"
      
      @relative_files_method = "# Get current path\nstrPath = File.expand_path(File.dirname(__FILE__)) + \"\\\\\""
      
      @language = "rb"
      language_class_setup :com
    end
    
    def quoted_string
      String.class_eval do
        def quoted
          "'#{self}'"
        end
      end
    end

    def quoted_array
      Array.class_eval do
        def quoted
          "[#{self.map{|x| x.quoted}.join(', ')}]"
        end
      end
    end
    
    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        comment "Instantiate Object"
      end
      output ["#{object} = WIN32OLE.new(\"#{options[:com]}\")"]
      unless options[:from_createobject] === true
        output ""
      end
    end
    
    def with_tkfio_start(object, options)
      output "#{object} = oTK.FieldInfo(#{options[:name].quoted}, #{options[:instance].quoted})"
    end
    
    def with_svr_start(object, options)
      start_object object, :com => "APServer.Object"
    end

    def with_mer_start(object, options)
      start_object object, :com => "APMeridian.Object"
    end

    def with_tk_start(object, options)
      start_object object, :com => "APToolkit.Object"
    end
    
    def with_wgw_start(object, options)
      start_object object, :com => "APWebGrabber.Object"
    end
    
    def with_wg_start(object, options)
      start_object object, :com => "APWebGrabber.Object"
    end
    
    def with_dc_start(object, options)
      case @vars[:product][:version]
      when "2009", "2010"
        start_object object, :com => "APDocConv.Object"
      else
        start_object object, :com => "APDocConverter.Object"
      end
    end
    
    def with_dcw_start(object, options)
      start_object object, :com => "DocConverterWBE.Object"
    end
    
    def with_multi_end(object, options = Hash.new)
      output ""
      comment "Release Object"
      output ["#{object} = ''"]
      output "" unless options[:from_createobject] === true
    end
    
    def set_property(method, assignment, no_object = false)
      if no_object
        "#{method} = #{assignment}"
      else
        "#{@object_variable}.#{method} = #{assignment}"
      end
    end
    
    def get_property(property, variable, append = nil)
      if append
        "#{variable} = #{@object_variable}.#{property} #{@concat_symbol} #{append.quoted}"
      else
        "#{variable} = #{@object_variable}.#{property}"
      end
    end
    
    def method(method, args)
      "#{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')})"
    end
    
    def assign_variable_from_method(variable, method, args, options = Hash.new)
      "#{variable} = #{self.method(method,args)}"
    end
    
    def if_control_start(subject, test, assertion)
      "if #{subject} #{test} #{assertion.quoted}"
    end

    def select_control_start(subject)
      "case #{subject}"
    end

    def case_control_start(subject)
      "when #{subject.quoted}"
    end

    def case_control_default_start
      "else"
    end

    def for_control_start(name, _start, _end)
      variable(name, "integer", _start)
      "for #{variable(name)} in #{variable(name)}..#{_end}"
    end
    
    def _error(method, variable, options)
      if options[:assert_result]
        [
          'puts "Error with ' + method.to_s + ':"',
          'puts "#{' + variable + '.' + options[:assert_result] + 'Status}"',
          'puts results.Details',
          'exit 1'
        ]
      else
        'puts "Error in ' + method.to_s + ': #{' + variable.to_s + '}"'
      end
    end

    def write_results_method
    end

    def write_out(output, options = Hash.new)
      output "puts #{output}"
    end

    def concat(*args)
      # Could update to work better
      # Example: "#{var}Filename#{var2}.jpg"
      args.map!{|item| item.is_a?(Symbol) ? "#{item}.to_s".to_sym : item}
      args.map{|item| item.quoted}.join(" #{@concat_symbol} ").to_sym
    end
  end
end