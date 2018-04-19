module ASP
  class Code < VBS::Code
    
    def language_init
      # @indents = 0
      
      @code_start = "<%"
      @code_end = "%>"
      @after_main_code = ["' Process Complete",'Response.Write "Done!"',""]
      
      @comment_symbol = "' "
      @concat_symbol = "&"
      @equals_symbol = "="
      @not_equals_symbol = "<>"
      
      @if_end_symbol = "End If"
      @else_symbol = "Else"
      @case_statment_end_symbol = "End Select"
      @for_control_end_symbol = "Next"
      
      @relative_files_method = "strPath = Server.MapPath(\".\") & \"\\\""
      
      @language = "asp"
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
      out << '  Response.Write("Error in " & method & ": " & outputCode)' if type == :default
      if type == :result
        out << [
          '  Response.Write("Error with " & method & ": <br/>" _',
          '    & errorStatus & "<br/>" _',
          '    & oResult.details)',
          '  Response.End'
        ]
      end
      out << 'End Sub'
    end

    def write_results_method
    end
    
    def copyright(textArray)
      output = ""
      textArray.each do |line|
        if line.empty?
          output << "\n"
        else
          output << "<!-- #{line} -->"
        end
      end
      return output
    end

    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        comment "Instantiate Object"
      end
      output "Set #{object} = Server.CreateObject(\"#{options[:com]}\")"
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

    def write_out(output, options = Hash.new)
      output "Response.Write(#{output})"
    end
  end
end