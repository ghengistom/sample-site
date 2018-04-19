module PHP
  class Code < Generic::Code
    def quoted_array
      Array.class_eval do
        def quoted
          "array(#{self.map{|x| x.quoted}.join(', ')})"
        end
      end
    end

    def language_init
      @code_start = "<?php"
      @code_end = "?>"
      @after_main_code = ["// Process Complete","echo \"Done!\";"]
      
      @concat_symbol = "."
      @equals_symbol = "=="
      @not_equals_symbol = "!="
      @object_symbol = '->'
      
      @if_end_symbol = "}"
      @case_statment_end_symbol = "}"
      @break_control_symbol = "break;"
      
      @relative_files_method = "// Get current path\n$strPath = dirname(__FILE__) . \"\\\\\";"
      
      @language = "php"
      language_class_setup :com
    end
    
    def errors_method(type)
      out = []
      out << ""
      out << '// Error Handling'
      
      if type == :result
        out << [
          'function Error($method, $oResults, $errorStatus) {',
          '  echo "Error with " . $method . ": <br/>"',
        	'    . $errorStatus . "<br/>"',
        	'    . $oResults->details;',
          '  exit(1);',
          '}'
        ]
      else
        out << [ 
          'function Error($method, $outputCode) {',
          '  echo "Error in " . $method . ": " . $outputCode;',
          '}'
        ]
      end
    end

    def write_results_method
    end
    
    def copyright(textArray)
      output = "#{@code_start}\n"
      textArray.each do |line|
        if line.empty?
          output << "\n"
        else
          output << "// #{line}"
        end
      end
      output << "#{@code_end}\n"
      return output
    end
    
    def with_tkfio_start(object, options)
      output "#{object} = $oTK#{@object_symbol}FieldInfo(#{options[:name].quoted}, #{options[:instance].quoted});"
    end
    
    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        comment "Instantiate Object"
      end
      output "#{object} = new COM(\"#{options[:com]}\");"
      unless options[:from_createobject] === true
        output ""
      end
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
      output "#{object} = null;"
      output "" unless options[:from_createobject] === true
    end
    
    def set_property(property, assignment, no_object = false)
      if no_object
        "#{property} = #{assignment};"
      else
        "#{@object_variable}#{@object_symbol}#{property} = #{assignment};"
      end
    end
    
    def get_property(property, variable, append = nil)
      if append
        "#{variable} = #{@object_variable}#{@object_symbol}#{property} #{@concat_symbol} #{append.quoted};"
      else
        "#{variable} = #{@object_variable}#{@object_symbol}#{property};"
      end
    end
    
    def method(method, args)
      "#{@object_variable}#{@object_symbol}#{method}(#{array_to_quoted_strings(args).join(', ')});"
    end
    
    def get_variable_name(string)
      "$#{string}"
    end
    
    def assign_variable_from_method(variable, method, args, options = Hash.new)
      "#{variable} = #{self.method(method,args)}"
    end
    
    def if_control_start(subject, test, assertion)
      "if (#{subject} #{test} #{assertion.quoted}) {"
    end

    def select_control_start(subject)
      "switch (#{subject}) {"
    end

    def case_control_start(subject)
      "case #{subject.quoted}:"
    end

    def case_control_default_start
      "default:"
    end

    def for_control_start(name, _start, _end)
      variable(name, "integer", _start)
      ["for (#{variable(name)}; #{variable(name)} <= #{_end}; #{variable(name)}++)","{"]
    end
    
    def _error(method, variable, options)
      # WHEN READY ADD THIS. USE AUTO ROTATE EXAMPLE TO TEST
      # unless variable.include? "$"
      #   variable = "$#{variable}"
      # end
      if options[:assert_result]
        "Error(#{method.to_s.quoted}, #{variable}, #{options[:result_variable]}#{@object_symbol}#{options[:assert_result]}Status);"
      else
        "Error(#{method.to_s.quoted}, #{variable});"
      end
    end

    def write_out(output, options = Hash.new)
      output "echo #{output};"
    end
  end
end