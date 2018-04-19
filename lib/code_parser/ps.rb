module PS
  class Code < Generic::Code
    def language_init
      @after_main_code = [
        "# Process Complete",
        'Write-Host "Done!"',
        ''
      ]
      
      @concat_symbol = "+"
      @comment_symbol = "# "
      @equals_symbol = "-eq"
      @not_equals_symbol = "-ne"
      @lt_symbol = '-lt'
      @gt_symbol = '-gt'
      @else_symbol = '} else {'
      
      @if_end_symbol = "}"
      @else_symbol = "} else {"
      @for_control_end_symbol = "}"
      
      @case_statment_end_symbol = "}"
      @case_option_end_symbol = "}"
      
      # variable "strPath"
      @relative_files_method = "# Get current path" + "\n" + "$invocation = (Get-Variable MyInvocation)\.Value" + "\n" + "$strPath = (Split-Path $invocation.MyCommand.Path) + \"\\\""

      @language = "ps"
      language_class_setup :com
    end
    
    def quoted_bool
      TrueClass.class_eval do
        def quoted
          '$True'
        end
      end

      FalseClass.class_eval do
        def quoted
          '$False'
        end
      end
    end

    def get_variable_name(string)
      "$#{string}"
    end

    def errors_method(type)
      results = if type == :result
        "oResult, $errorStatus" 
      else
        "outputCode"
      end
      
      out = []
      out << "# Error Handling"
      out << "function ErrorHandler($method, $#{results})"
      out << "{"
      out << '  Write-Host("Error in ${method}: ${outputCode}")' if type == :default
      if type == :result
        out << [
          '  Write-Host("Error with ${method}: ")',
          '  Write-Host("$errorStatus")',
          '  Write-Host("$oResult.details")'
        ]
      end
      out << '  Exit 1'
      out << '}'
    end

    def write_results_method
    end
    
    # def with_tkfio_start(object, options)
    #   output "Set #{object} = oTK.FieldInfo(#{options[:name].quoted}, #{options[:instance].quoted})"
    # end
    
    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        comment "Instantiate Object"
      end
      output "#{object} = New-Object -ComObject #{options[:com]}"
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
      output "#{object} = $null"
      output "" unless options[:from_createobject] === true
    end

    # def relative_file(string = "")
    #   @files << string
    #   unless string.empty?
    #     # was this:
    #     # "\"${#{variable("strPath")}}#{string}\"".to_sym
    #     # hard coded strPath to avoid the extra $
    #     # could not figure out how to remove it otherwise
    #     "\"${strPath}#{string}\"".to_sym
    #   else
    #     # ?
    #     "#{variable("strPath")}".to_sym
    #   end
    # end
    
    def set_property(method, assignment, no_object = false)
      # if no_object
      #   "#{method} = #{assignment.quoted}"
      # else
      #   if assignment.quoted == 'true'
      #   #   "#{@object_variable}.#{method} = $True"
      #   else
      #   #   "#{@object_variable}.#{method} = 1#{assignment.quoted}"
      #   end
      #   "#{@object_variable}.#{method} = #{assignment.quoted}"
      # end

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
    
    # This FAILS if I don't leave it in Not sure what it's doing yet
    def assign_variable_from_method(variable, method, args, options=Hash.new)
      "#{variable} = #{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')})"
    end
    
    def _error(method, variable, options)
      unless variable.include? "$"
        variable = "$#{variable}"
      end
      error_string = ""
      error_string << "ErrorHandler (#{method.to_s.quoted}, #{variable})"
      error_string << ", #{options[:result_variable]}.#{options[:assert_result]}Status" if options[:assert_result]
      return error_string
    end
    
    def if_control_start(subject, test, assertion)
      ["If (#{subject} #{test} #{assertion.quoted})", "{"]
    end

    def select_control_start(subject)
      ["Switch (#{subject})","{"]
    end

    def case_control_start(subject)
      ["#{subject.quoted}", "{"]
    end

    def case_control_default_start
      ["Default", "{"]
    end
    
    def for_control_start(variable, _start, _end)
      variable(variable, "integer")
      ["for ($#{variable} = #{_start}; $#{variable} #{@lt_symbol} #{_end}; $#{variable}++)","{"]
    end
    
    def define_variables
      # variables do not need to be declared
    end

    def write_out(output, options = Hash.new)
      output "Write-Host #{output}"
    end
    
  end
end