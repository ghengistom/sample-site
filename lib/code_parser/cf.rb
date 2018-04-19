module CF
  class Code < Generic::Code
    def quoted_array_string
      Array.class_eval do
        def quoted
          "[#{self.map{|x| x.quoted}.join(', ')}]"
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

    def language_init
      @code_start = "<CFSCRIPT>"
      @code_end = "</CFSCRIPT>"
      @after_main_code = "// Process Complete\nWriteOutput(\"Done!\");"
      
      @equals_symbol = "=="
      @not_equals_symbol = "!="
      
      @if_end_symbol = "}"
      @case_statment_end_symbol = "}"
      @break_control_symbol = "break;"
      
      @property_get_symbol = "Get_"
      
      @cfobjects = []

      @vars[:wg][:port] = 54545
      @vars[:wgw][:port] = 54545
      @vars[:dc][:port] = 54546
      @vars[:dcw][:port] = 54546
      @vars[:mer][:port] = 54545
      
      @header << "<!-- Example uses the .NET DLL which requires -->"
      @header << "<!-- Coldfusion 8 or above -->"
      @header << ""
      
      @relative_files_method = "// Get current path\nstrPath = ExpandPath(\".\") & \"\\\";"
      
      @wg_paths = {
        "WebGrabber Enterprise" => 'C:\Program Files\activePDF\WebGrabber Enterprise\bin\Proxy\APWebGrabberProxy.dll',
        "WebGrabber WBE" => 'C:\Program Files\activePDF\WebGrabber WBE\bin\APWebGrabberProxy.dll',
        "WebGrabber" => 'C:\Program Files\activePDF\WebGrabber\bin\APWebGrabber.Net35.dll'
      }
      
      @wg_proxy_objects = {
        "WebGrabber Enterprise" => 'APWebGrabberProxy.APWebGrabber',
        "WebGrabber WBE" => 'APWebGrabberProxy.APWebGrabber',
        "WebGrabber" => 'APWebGrabber.WebGrabber'
      }
      
      @language = "cf"
      language_class_setup :net
    end
    
    def errors_method(type)
      out = []
      out << ""
      out << '// Error Handling'
      
      if type == :result
        out << [
          'Function Error(method, oResults, errorStatus) {',
          '  WriteOutput("Error with " & method & ": <br/>"',
          '    & errorStatus &  "<br/>"',
          '    & oResults.Get_details());'
        ]
      else
        out << [
          'Function Error(method, outputCode) {',
          '  WriteOutput("Error in " & method & ": " & outputCode);'
        ]
      end
      
      out << '}'
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
    
    def with_tkfio_start(object, options)
      output "#{object} = oTK.FieldInfo(#{options[:name].quoted}, #{options[:instance].quoted});"
    end
    
    def start_object_old(options = Hash.new)
      "// Instantiate Object#{options[:comment]}\n#{options[:object]} = CreateObject(\".NET\", \"#{options[:net_name]}\", \"#{options[:path]}\");\n"
    end
    
    def start_object(object, options = Hash.new)
      unless options[:from_createobject] === true
        output ""
        comment "Instantiate Object"
      end
      output "#{object} = CreateObject(\".NET\", \"#{options[:class]}\", \"#{options[:path]}\");"
      unless options[:from_createobject] === true
        output ""
      end
    end

    def with_svr_start(object, options)
      case @vars[:product][:version]
      when "2009"
        output start_object_old(:object => object, :net_name => "APServer.Server", :path => "C:\\Program Files\\activePDF\\Server\\bin\\APServer.dll")
      else
        output start_object_old(:object => object, :net_name => "APServer.Server", :path => "C:\\Program Files\\activePDF\\Server\\bin\\APServer.Net35.dll")
      end
    end

    def with_mer_start(object, options)
      case @vars[:product][:version]
      when "2010"
        output start_object_old(:object => object, :net_name => "APMeridian.Server", :path => "C:\\Program Files\\activePDF\\Meridian API\\bin\\APMeridian.dll")
      else
        # commented out from Server copy and paste. When Meridian 2015+ comes out this will need to be updated
        #output start_object_old(:object => object, :net_name => "APMeridian.Server", :path => "C:\\Program Files\\activePDF\\Meridian\\bin\\APMeridian.Net35.dll")
      end
    end
    
    def with_tk_start(object, options)
      output start_object_old(:object => object, :net_name => "APToolkitNET.Toolkit", :path => 'C:\Program Files\activePDF\Toolkit\DotNetComponent\2.0\APToolkitNET.dll')
    end
    
    def with_wgw_start(object, options)
      comment = "\n"
      comment << "// For WebGrabber in ColdFusion you must use a proxy DLL"
      output start_object_old(:comment => comment, :object => object, :net_name => @wg_proxy_objects[@vars[:product][:name]], :path => @wg_paths[@vars[:product][:name]])
    end
    
    def with_wg_start(object, options)
      case @vars[:product][:version]
      when "2009", "2010"
        comment = "\n"
        comment << "// For WebGrabber in ColdFusion you must use a proxy DLL"
        output start_object_old(:comment => comment, :object => object, :net_name => @wg_proxy_objects[@vars[:product][:name]], :path => @wg_paths[@vars[:product][:name]])
      else
        output start_object_old(:object => object, :net_name => @wg_proxy_objects[@vars[:product][:name]], :path => @wg_paths[@vars[:product][:name]])
      end
    end
    
    def with_dc_start(object, options)
      case @vars[:product][:version]
      when "2009", "2010"
        output start_object_old(:object => object, :net_name => "APDocConv.APDocConverter", :path => 'C:\Program Files\activePDF\DocConverter Enterprise\APDocConv.dll')
      else
        case @vars[:product][:name]
        when "DocConverter"
          @vars[:product][:path] = "C:\\Program Files\\activePDF\\DocConverter\\bin\\APDocConverter.Net35.dll"
        when "CADConverter"
          @vars[:product][:path] = "C:\\Program Files\\ActivePDF\\CADConverter\\bin\\APDocConverter.Net35.dll"
        end
        output start_object_old(:object => object, :net_name => "APDocConverter.DocConverter", :path => @vars[:product][:path])
      end
    end
    
    def with_dcw_start(object, options)
      output start_object_old(:object => object, :net_name => "activePDF.API.DocConverterWBE.DocConverter", :path => 'C:\Program Files\activePDF\DocConverter WBE\bin\activePDF.API.DocConverterWBE.dll')
    end
    
    def with_multi_end(object, options = Hash.new)
      output ""
      comment "Release Object"
      output "#{object} = 0;"
      output "" unless options[:from_createobject] === true
    end
    
    def set_property(method, assignment, no_object = false)
      if no_object
        "#{method} = #{assignment};"
      else
        "#{@object_variable}.Set_#{method}(#{assignment});"
      end
    end

    def get_property(property, variable, append = nil)
      if append
        "#{variable} = #{@object_variable}.Get_#{property} & #{append.quoted};"
      else
        "#{variable} = #{@object_variable}.Get_#{property}();"
      end
    end
    
    def method(method, args)
      "#{@object_variable}.#{method}(#{array_to_quoted_strings(args).join(', ').gsub('#', '##')});"
    end
    
    def assign_variable_from_method(variable, method, args, options = Hash.new)
      "#{variable} = #{self.method(method,args)}"
    end
    
    def if_control_start(subject, test, assertion)
      "if(#{subject} #{test} #{assertion.quoted}) {"
    end

    def select_control_start(subject)
      ["switch(#{subject})","{"]
    end

    def case_control_start(subject)
      "case #{subject.quoted}:"
    end

    def case_control_default_start
      "default:"
    end

    def for_control_start(name, _start, _end)
      variable(name, "integer", _start)
      ["for (#{variable(name)}; #{variable(name)} <= #{_end}; #{variable(name)}=#{variable(name)} + 1)","{"]
    end
    
    def _error(method, variable, options)
      if options[:assert_result]
        "Error(#{method.to_s.quoted}, #{variable}, #{variable}.Get_#{options[:assert_result]}Status());"
      else
        "Error(#{method.to_s.quoted}, #{variable});"
      end
    end
    
    def assert_result_if_subject(variable, assert_result)
      "#{variable}#{@object_symbol}Get_#{assert_result}Status()"
    end

    def write_out(output, options = Hash.new)
      output "WriteOutput(#{output});"
    end

    def quoted_enum(enum)
      if enum.has_key?(:namespace)
        namespace = enum[:namespace]
      else
        namespace = @vars[:version][:namespace]
      end
      cfobject_info = "#{namespace}->#{enum[:enum]}"
      #unless @cfobjects.include? cfobject_info
      unless cfobject_info.in? @cfobjects
        output "enum#{enum[:enum]} = CreateObject(\".NET\", \"#{namespace}.#{enum[:enum]}\", \"#{@vars[:version][:dll_paths]}\");"
      end
      @cfobjects << cfobject_info
      "enum#{enum[:enum]}.#{enum[:net]}"
    end    
  end
end