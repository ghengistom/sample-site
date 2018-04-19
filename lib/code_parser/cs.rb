module CS
  class Code < Generic::Code
    
    def quoted_string
      String.class_eval do
        def quoted
          '"' + self.gsub('\\','\\\\\\') + '"'
        end
      end
    end
    
    def quoted_float
      Float.class_eval do
        def quoted
          "#{self}f"
        end
      end
    end

    def quoted_array
      # This will not handle arrays with mixed types of values
      Array.class_eval do
        def quoted
          variable_type = case self[0]
          when String, Symbol
            "string"
          when Float
            "float"
          when PointF
            "PointF"
          end
          "new #{variable_type}[] {#{self.map{|x| x.quoted}.join(', ')}}"
        end
      end
    end

    def quoted_point_f
      PointF.class_eval do
        def quoted
          "new PointF(#{self.x.quoted}, #{self.y.quoted})"
        end
      end
    end
    
    def language_init
      @indents = 2
      
      @code_start = "class Examples\n{\n  public static void Example()\n  {"
      @code_end = "}"
      @after_main_code = [
        "  // Process Complete",
        "  WriteResults(\"Done!\");",
        "}"
      ]
      
      @concat_symbol = "+"
      @equals_symbol = "=="
      @not_equals_symbol = "!="
      @break_control_symbol = "break;"
      
      @vars[:wg][:port] = 54545
      @vars[:wgw][:port] = 54545
      @vars[:dc][:port] = 54546
      @vars[:dcw][:port] = 54546
      @vars[:mer][:port] = 54545
      
      @if_end_symbol = "}"
      @case_statment_end_symbol = "}"
      
      # setup variable types
      @variable_types[:iresult] = "IResult"
      @variable_types[:long] = "long"
      @variable_types[:short] = "short"
      @variable_types[:byte] = "byte[]"
      @variable_types[:array] = "Array"
      @variable_types[:array_string] = "string[]"
      @variable_types[:array_float] = "float[]"
      @variable_types[:array_point] = "PointF[]"
      @variable_prefix_types[:long] = "long"
      
      @relative_files_method = "strPath = System.AppDomain.CurrentDomain.BaseDirectory;"
      
      @language = "cs"
      language_class_setup :net

      @header << "using System;"
    end
    
    def errors_method(type)
      out = Array.new
      out << ""
      out << "// Error Handling"
      if type == :result
        out << [
          'public static void ErrorHandler(string strMethod, ADK.Results.Result results, string errorStatus)',
          '{',
          '  WriteResults("Error with " + strMethod);',
          '  WriteResults(errorStatus);',
          '  WriteResults(results.Details);',
          '  if (results.Origin.Function != strMethod)',
          '  {',
          '    WriteResults(results.Origin.Class + "." + results.Origin.Function);',
          '  }',
          '  if (results.ResultException != null)',
          '  {',
          '    // To view the stack trace on an exception uncomment the line below',
          '    //WriteResults(results.ResultException.StackTrace);',
          '  }',
          '  Environment.Exit(1);',
          '}'
        ]
      else
        out << "public static void ErrorHandler(string strMethod, object rtnCode)"
        out << "{"
        out << "  WriteResults(strMethod + \" error:  \" + rtnCode.ToString());"
        out << "}"
      end
    end

    def write_results_method
      out = Array.new
      out << [
        '',
        '// Write output data',
        'public static void WriteResults(string content)',
        '{',
        '  // Choose where to write out results',
        '',
        '  // Debug output',
        '  //System.Diagnostics.Debug.WriteLine("ActivePDF: * " + content);',
        '',
        '  // Console',
        '  Console.WriteLine(content);',
        '',
        '  // Log file',
        '  //using (System.IO.TextWriter writer = new System.IO.StreamWriter(System.AppDomain.CurrentDomain.BaseDirectory + "application.log", true))',
        '  //{',
        '  //    writer.WriteLine("[" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "]: => " + content);',
        '  //}',
        '}'
      ]
    end
    
    def set_property(method, assignment, no_object = false)
      if no_object
        "#{method} = #{assignment};"
      else
        "#{@object_variable}.#{method} = #{assignment};"
      end
    end
    
    def get_property(property, variable, append = nil)
      if append
        "#{variable} = #{@object_variable}.#{property} #{@concat_symbol} #{append.quoted};"
      else
        "#{variable} = #{@object_variable}.#{property};"
      end
    end
    
    def method(method, args)
      "#{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')});"
    end
    
    def assign_variable_from_method(variable, method, args, options = Hash.new)
      if options[:class]
        "#{options[:class]} #{variable} = #{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')});"
      else
        "#{variable} = #{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')});"
      end
    end
    
    def _error(method, variable, options)
      error_string = ""
      error_string << "ErrorHandler(#{method.to_s.quoted}, #{variable}"
      error_string << ", #{options[:result_variable]}.#{options[:assert_result]}Status.ToString()" if options[:assert_result]
      error_string << ");"
    end
    
    def if_control_start(subject, test, assertion)
      ["if (#{subject} #{test} #{assertion.quoted})","{"]
    end

    def select_control_start(subject)
      ["switch (#{subject})","{"]
    end

    def case_control_start(subject)
      "case #{subject.quoted}:"
    end

    def case_control_default_start
      "default:"
    end

    def for_control_start(variable, _start, _end)
      variable(variable, "integer")
      ["for (#{variable} = #{_start}; #{variable} <= #{_end}; #{variable}++)","{"]
    end
    
    def with_multi_end(object, options = Hash.new)
      output ""
      comment "Release Object"
      if options[:dispose]
        output "#{object}.Dispose();"
      else
        output "#{object} = null;"
      end
      output "" unless options[:from_createobject] === true
    end
    
    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        @header << ""
        @header << _comment("Make sure to add the ActivePDF product .NET DLL(s) to your application.")
        @header << _comment(".NET DLL(s) are typically found in the products 'bin' folder.")
        comment "Instantiate Object"
      end
      output "#{options[:class]} #{object} = new #{options[:call]};"
      unless options[:from_createobject] === true
        output ""
      end
    end
    
    def with_portal_start(object, options)
      @code_start = "partial class Example : System.Web.UI.Page\n{"
      @code_end = "}"
      @after_main_code = ""
      @object_variable = "this.PdfWebControl1"
      
      @control_params = options[:control_params]
      
      @header << [
        "using System.Diagnostics;",
        "using System.IO;"
      ]
    end
    
    def with_portal_end(object); end
    
    def custom_aspx(html)
      @custom_aspx = html
    end
    
    def with_svr_start(object, options)
      using = []
      using << "APServer"
      case @vars[:product][:version]
      when "2009"
      else
        using << "ServerDK.Results"
      end
      
      options = {
        :using => using,
        :class => "APServer.Server",
        :call => "APServer.Server()"
      }      
      start_object object, options
    end
    
    def with_tkfio_start(object, options)
      output "APToolkitNET.FieldInfo #{object} = oTK.FieldInfo(#{options[:name].quoted}, #{options[:instance].quoted});"
    end
    
    def with_tk_start(object, options)
      options = {
        :using => "APToolkitNET",
        :dll => "APToolkit.DLL",
        :class => "APToolkitNET.Toolkit",
        :call => "APToolkitNET.Toolkit()"
      }
      start_object object, options
    end
    
    def with_wgw_start(object, options)
      options = {
        :using => "APWebGrbNET",
        :dll => "APWebGrb.dll",
        :class => "APWebGrbNET.APWebGrabber",
        :call => "APWebGrbNET.APWebGrabber()"
      }
      start_object object, options
    end
    
    def with_wg_start(object, options)
      case @vars[:product][:version]
      when "2009", "2010"
        options = {
          :using => "APWebGrbNET",
          :dll => "APWebGrb.dll",
          :class => "APWebGrbNET.APWebGrabber",
          :call => "APWebGrbNET.APWebGrabber()"
        }
      else
        options = {
          :using => "APWebGrabber",
          :dll => "APWebGrb.dll",
          :class => "APWebGrabber.WebGrabber",
          :call => "APWebGrabber.WebGrabber()"
        }
      end
      start_object object, options
    end
    
    def with_dc_start(object, options)
      case @vars[:product][:version]
      when "2009", "2010"
        options = {
          :using => "APDocConv",
          :dll => "APDocConverter.dll",
          :class => "APDocConv.APDocConverter",
          :call => "APDocConv.APDocConverter()"
        }
      else
        options = {
          :using => "APDocConverter",
          :dll => "APDocConverter.Net35.dll",
          :class => "APDocConverter.DocConverter",
          :call => "APDocConverter.DocConverter()"
        }
      end
      start_object object, options
    end
    
    def with_dcw_start(object, options)
      options = {
        :using => ["activePDF.API.DocConverterWBE","activePDF.Results"],
        :dll => "DocConverterWBE",
        :class => "activePDF.API.DocConverterWBE.DocConverter",
        :call => "activePDF.API.DocConverterWBE.DocConverter()"
      }      
      start_object object, options
    end
    
    def oDCw_assert_equal(method, args, options)
      output "IResult irSuccess = new Result(Code.Success, \"#{method}\");"
      output assign_variable_from_method(options[:variable_name],method,args, :class => "IResult")
      output if_control_start(options[:variable_name] + ".Status",@not_equals_symbol,"irSuccess.Status".to_sym)
      output error(method,"#{options[:variable_name]}.Status + \" - \" + #{options[:variable_name]}.Details")
      output "#{@if_end_symbol}"
    end

    def with_mer_start(object, options)
      options = {
        :using => "APMeridian",
        :dll => "APMeridian.dll",
        :class => "APMeridian.Meridian",
        :call => "APMeridian.Meridian()"
      }      
      start_object object, options
    end

    def with_xt_start(object, options)
      options = {
        :using => "APXtractor",
        :dll => "APXtractor.dll",
        :class => "APXtractor.Xtractor",
        :call => "APXtractor.Xtractor()"
      }      
      start_object object, options
    end
    
    def imports(string)
      @header.pop if @header.last == ""
      @header << "using #{string};" unless @header.include? "using #{string};"
    end
    
    def define_variables
      variables = []
      @variables.each do |n,v|
        variables << "#{v} #{n};"
      end
      variables << ""
    end

    def write_out(output, options = Hash.new)
      convertostring = ".ToString()" if options.has_key?(:tostring)
      output "WriteResults(#{output}#{convertostring});"
    end
  end
end
