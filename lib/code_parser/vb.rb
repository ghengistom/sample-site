module VB
  class Code < Generic::Code

    def quoted_array
      Array.class_eval do
        def quoted
          "{#{self.map{|x| x.quoted}.join(', ')}}"
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
      
      @code_start = ["Public Class Examples","  Sub Example()"]
      @code_end = "End Class"
      @after_main_code = [
        "  ' Process Complete",
        "  WriteResults(\"Done!\")",
        "End Sub"
      ]
      
      @vars[:wg][:port] = 54545
      @vars[:wgw][:port] = 54545
      @vars[:dc][:port] = 54546
      @vars[:dcw][:port] = 54546
      @vars[:mer][:port] = 54545
      
      [:integer, :long, :iresult, :fixnum, :int, :short].each {|t| @variable_types[t] = "Integer" }
      [:string, :str].each {|t| @variable_types[t] = "String" }
      [:bool, :boolean].each {|t| @variable_types[t] = "Boolean" }
      [:float].each {|t| @variable_types[t] = "Single" }
      [:array].each {|t| @variable_types[t] = "Array" }
      [:array_string].each {|t| @variable_types[t] = "String()" }
      [:array_float].each {|t| @variable_types[t] = "Float()" }
      [:array_point].each {|t| @variable_types[t] = "PointF" }

      @comment_symbol = "' "      
      @equals_symbol = "="
      @not_equals_symbol = "<>"
      @case_statment_end_symbol = "End Select"
      @for_control_end_symbol = "Next"
      
      @if_end_symbol = "End If"
      @else_symbol = "Else"
      
      @relative_files_method = "strPath = AppDomain.CurrentDomain.BaseDirectory"
      
      @language = "vb"
      language_class_setup :net

      @header << "Imports System"
    end
    
    def errors_method(type)
      out = Array.new
      out << ""
      out << "' Error Handling"
      
      if type == :result
        out << [
          'Sub ErrorHandler(ByVal strMethod As String, ByVal results As ADK.Results.Result, ByVal errorStatus As String)',
          '  WriteResults("Error with " + strMethod)',
          '  WriteResults(errorStatus)',
          '  WriteResults(results.Details)',
          '  If results.Origin.Function <> strMethod Then',
          '    WriteResults(results.Origin.Class + "." + results.Origin.Function)',
          '  End If',
          '  If Not results.ResultException Is Nothing Then',
          '    \' To view the stack trace on an exception uncomment the line below',
          '    \'WriteResults(results.ResultException.StackTrace)',
          '  End If',
          '  Environment.Exit(1)'
        ]
      else
        out << [
          _comment("Error messages written to debug output"),
          "Sub ErrorHandler(ByVal strMethod, ByVal RtnCode)",
          "  WriteResults(strMethod + \" error:  \" + rtnCode.ToString())",
        ]
      end
      out << "End Sub"
    end

    def write_results_method
      out = Array.new
      out << [
        '',
        _comment("Write output data"),
        'Sub WriteResults(content As String)',
        '  \' Choose where to write out results',
        '',
        '  \' Debug output',
        '  \'System.Diagnostics.Debug.WriteLine("ActivePDF: * " + content)',
        '',
        '  \' Console',
        '  Console.WriteLine(content)',
        '',
        '  \' Log file',
        '  \'Using tw = New System.IO.StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "application.log", True)',
        '  \'   tw.WriteLine("[" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "]: => " + content)',
        '  \'End Using',
        'End Sub'
      ]
    end
    
    def with_portal_start(object, options)
      @code_start = "Partial Class Example\n  Inherits System.Web.UI.Page"
      @code_end = "End Class"
      @after_main_code = ""
      @object_variable = "Me.PdfWebControl1"
      
      @control_params = options[:control_params]
      
      @header = [
        "Imports System.IO",
        ""
      ]
    end
    
    def with_portal_end(object); end
    
    def custom_aspx(html)
      @custom_aspx = html
    end
    
    def with_tkfio_start(object, options)
      output "APToolkitNET.FieldInfo #{object} = oTK.FieldInfo(#{options[:name].quoted}, #{options[:instance].quoted})"
    end
    
    def with_svr_start(object, options)
      options = {
        :using => "APServer",
        :dll => "APServer.DLL",
        :class => "APServer.Server",
        :call => "APServer.Server()"
      }      
      start_object object, options
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
        :dll => ["activePDF.API.DocConverterWBE.dll","activePDF.Results.dll"],
        :class => "activePDF.API.DocConverterWBE.DocConverter",
        :call => "activePDF.API.DocConverterWBE.DocConverter()"
      }      
      start_object object, options
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

    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        @header << ""
        @header << _comment("Make sure to add the ActivePDF product .NET DLL(s) to your application.")
        @header << _comment(".NET DLL(s) are typically found in the products 'bin' folder.")
        comment "Instantiate Object"
      end
      output "Dim #{object} As #{options[:class]} = New #{options[:call]}"
      unless options[:from_createobject] === true
        output ""
      end
    end
    
    def with_multi_end(object, options = Hash.new)
      output ""
      comment "Release Object"
      if options[:dispose]
        output "#{object}.Dispose()"
      else
        output "#{object} = Nothing"
      end
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
      if options[:class]
        "Dim #{variable} As #{options[:class]} = #{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')})"
      else
        "#{variable} = #{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ')})"
      end
    end
    
    def _error(method, variable, options)
      error_string = ""
      error_string << "ErrorHandler(#{method.to_s.quoted}, #{variable}"
      error_string << ", #{options[:result_variable]}.#{options[:assert_result]}Status.ToString()" if options[:assert_result]
      error_string << ")"
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

    def for_control_start(name, _start, _end)
      variable(name, "integer")
      "For #{variable(name)} = #{_start} To #{_end}"
    end
    
    def oDCw_assert_equal(method, args, options)
      output "Dim irSuccess As IResult = New Result(Code.Success, \"#{method}\")"
      output assign_variable_from_method(options[:variable_name],method,args, :class => "IResult")
      output if_control_start(options[:variable_name] + ".Status",@not_equals_symbol,"irSuccess.Status".to_sym)
      output error(method,"#{options[:variable_name]}.Status & \" - \" & #{options[:variable_name]}.Details")
      output "#{@if_end_symbol}"
    end
    
    def imports(string)
      @header.pop if @header.last == ""
      @header << "Imports #{string}" unless @header.include? "Imports #{string}"
    end
    
    def define_variables
      output = ""
      count = 0
      output << "Dim "
      @variables.each do |n,v|
        count += 1
        case v
        when 'String()'
          v = 'String'
          n = "#{n}()"
        when 'Float()'
          v = 'Double'
          n = "#{n}()"
        when 'PointF'
          v = 'PointF'
          n = "#{n}()"
        end
        output << "#{n} As #{v}, "
        if count % 4 == 0
          output << "_\n      "
        end
      end
      if @variables.length % 4 == 0
        output.strip.chop.strip.chop + "\n"
      else
        output.strip.chop + "\n"
      end
    end

    def write_out(output, options = Hash.new)
      output "WriteResults(#{output})"
    end
  end
end