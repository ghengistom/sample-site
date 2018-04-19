module VBS
  class Code < Generic::Code
    def quoted_array
      Array.class_eval do
        def quoted
          "array(#{self.map{|x| x.quoted}.join(', ')})"
        end
      end
    end

    def language_init
      @indents = 0
      
      @after_main_code = [
        "' Process Complete",
        'Wscript.Echo("Done!")',
        ''
      ]
      
      @comment_symbol = "' "
      @equals_symbol = "="
      @not_equals_symbol = "<>"
      
      @if_end_symbol = "End If"
      @else_symbol = "Else"
      @case_statment_end_symbol = "End Select"
      @for_control_end_symbol = "Next"
      
      variable "FSO"
      @relative_files_method = "' Get current path\n" + 'Set FSO = CreateObject("Scripting.FileSystemObject")' + "\n" + "strPath = FSO.GetFile(Wscript.ScriptFullName).ParentFolder & \"\\\"\nSet FSO = Nothing"
      
      @language = "vbs"
      language_class_setup :com
    end
    
    def errors_method(type)
      results = if type == :result
        "oResult, errorStatus" 
      else
        "outputCode"
      end
      
      out = []
      out << "' Error Handling"
      out << "Sub ErrorHandler(method, #{results})"
      out << '  Wscript.Echo("Error in " & method & ": " & outputCode)' if type == :default
      if type == :result
        out << [
          '  Wscript.Echo("Error with " & method & ": " & vbcrlf _',
          '    & errorStatus & vbcrlf _',
          '    & oResult.details)',
          '  Wscript.Quit 1'
        ]
      end
      out << 'End Sub'
    end

    def write_results_method
    end
    
    def with_tkfio_start(object, options)
      output "Set #{object} = oTK.FieldInfo(#{options[:name].quoted}, #{options[:instance].quoted})"
    end
    
    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        comment "Instantiate Object"
      end
      output "Set #{object} = CreateObject(\"#{options[:com]}\")"
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
      output "Set #{object} = Nothing"
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
      "#{@object_variable}.#{method} #{array_to_quoted_strings(args).join(', ')}"
    end
    
    def assign_variable_from_method(variable, method, args, options=Hash.new)
      set = "Set " if options[:object]
      "#{set}#{variable} = #{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')})"
    end
    
    def _error(method, variable, options)
      error_string = ""
      error_string << "ErrorHandler #{method.to_s.quoted}, #{variable}"
      error_string << ", #{options[:result_variable]}.#{options[:assert_result]}Status" if options[:assert_result]
      return error_string
    end
    
    def if_control_start(subject, test, assertion)
      "If #{subject} #{test} #{assertion.quoted} Then"
    end

    def select_control_start(subject)
      "Select Case #{subject}"
    end

    def case_control_start(subject)
      "Case #{subject.quoted}"
    end

    def case_control_default_start
      "Case Else"
    end
    
    def for_control_start(var, _start, _end)
      variable(var, "integer")
      "For #{variable(var)} = #{_start} To #{_end}"
    end
    
    def define_variables
      output = ""
      count = 0
      output << "Dim "
      @variables.each do |n,v|
        count += 1
        output << "#{n}, "
        if count % 4 == 0
          output << "_\n "
        end
      end
      if @variables.length % 4 == 0
        output.strip.chop.strip.chop + "\n"
      else
        output.strip.chop + "\n"
      end
    end

    def write_out(output, options = Hash.new)
      output "Wscript.Echo(#{output})"
    end

  end
end