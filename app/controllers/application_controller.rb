class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_available_examples
  after_filter :discard_flash_if_xhr
  after_filter :set_access_control_headers
  
  before_filter :_reload_libs if Rails.env.development?
  
  rescue_from Exception, :with => :error_catcher if Rails.env.production?
  rescue_from ActionView::MissingTemplate, :with => :missing_template
  rescue_from CanCan::AccessDenied, :with => :access_denied
  
  helper_method :examples_path

  before_filter :authenticate_user_from_token!
  
  def initialize
    if Rails.env.development?
      @user_ip = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
      p "#{Time.now} #{@user_ip}"
      p "***********************"
    end
    super
  end

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    if user
      if user.valid_for_authentication? && (BCrypt::Password.new(user.token) == params[:user_token])
        sign_in user, store: false
      else
        # OPTIMIZE: Figure out how to record failed login attempts with Devise.
        # user.failed_attempts += 1
        # user.lock_access! if user.failed_attempts >= user.class.maximum_attempts
        # user.save
      end
    end
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    # headers['Access-Control-Request-Method'] = '*'
  end
  
  def examples_path(options = {})
    if options[:snippets]
      get_default_snippets.each do |key,value|
        options[:snippets].delete_if{|k,v| k == key && v == value}
      end
      options.delete(:snippets) if options[:snippets].empty?
    end
    super.gsub('%20', '_')
  end

  def examples_url(options = {})
    super.gsub('%20', '_')
  end

  def get_default_snippets
    output = {}
    @snippets_defaults.each do |category|
      output[category.first.to_s] = category.last.to_s
    end
    output
  rescue
    {}
  end
  
  def get_available_examples
    @search_examples = Example.is_active.collect{|e| e.title }.uniq
  end
  
  def set_products_versions
    @products_versions_start = Hash.new
    Product.all.each do |p|
      versions = Hash.new
      p.versions.order("sort_order ASC").each do |v|
        versions[v.name] = v.id
      end
      @products_versions_start[p.id] = versions
    end
    
    @products_versions_end = Hash.new
    Product.all.each do |p|
      versions = Hash.new
      p.versions.order("sort_order ASC").each do |v|
        versions[v.name] = v.id
      end
      versions["none"] = 0
      @products_versions_end[p.id] = versions
    end
  end
  
  def parse_generic_code(generic_code, language, options = Hash.new)
    begin
      options[:snippets] ||= Hash.new

      if params[:snippets]
       
        params[:snippets].each do |n,v|
          category = n.gsub(/[^\d]*/, "").to_i
          snippet = v.gsub(/[^\d]*/, "").to_i
          options[:snippets][category] = snippet
        end

      end
      
      options[:product] = Hash.new
      options[:product][:name] = @product.name
      options[:product][:version] = params[:version]
      options[:example] = Hash.new
      options[:example][:title] = @example.title
      options[:version] = Hash.new
      options[:version][:status] = @version.status
      options[:version][:dll_paths] = @version.dll_paths
      options[:version][:namespace] = @version.namespace
      options[:version][:class_name] = @version.class_name
      options[:version][:com_object] = @version.com_object
      options[:version][:object_name] = @version.object_name
      options[:version][:use_dispose] = @version.use_dispose
      options[:version][:beta] = @version.beta

      options[:product][:obj] = case @product.name
      when /^WebGrabber/
        'wg'
      when /^Server/
        'svr'
      when /^Toolkit/
        'tk'
      when "DocConverter WBE"
        'dcw'
      when /^DocConverter/
        'dc'
      when /^Portal/
        'portal'
      when /^Meridian/
        'mer'
      when /^Xtractor/
        'xt'
      when /^CADConverter/
        'dc'
      end
      
      case language
      when "php"
        PHP::Code.parse(generic_code, options).dump
      when "vb"
        VB::Code.parse(generic_code, options).dump
      when "vbs"
        VBS::Code.parse(generic_code, options).dump
      when "asp"
        ASP::Code.parse(generic_code, options).dump
      when "cs"
        CS::Code.parse(generic_code, options).dump
      when "cfm"
        CF::Code.parse(generic_code, options).dump
      when "rb"
        Ruby::Code.parse(generic_code, options).dump
      when "ps1"
        PS::Code.parse(generic_code, options).dump
      when "shell"
        Shell::Code.parse(generic_code, options).dump
      when "html"
        HTML::Code.parse(generic_code, options).dump
      end
    rescue Exception => e
      return {:code => "Example coming soon.", :error => e}
    end
  end
  
  def parse_generic_documentation(generic_code, language, options = Hash.new)
    begin
      Generic::Documentation.parse(generic_code, options).dump
    rescue Exception => e
      logger.error e.inspect
      return {:description => ["Documentation coming soon."]}
    end
  end
  
  def parse_generic_documentation_syntax(documentation, language, options = Hash.new)
    begin
      parser = case language
      when "php"
        PHP::Code.new
      when "vb"
        VB::Code.new
      when "vbs"
        VBS::Code.new
      when "asp"
        ASP::Code.new
      when "cs"
        CS::Code.new
      when "cfm"
        CF::Code.new
      when "rb"
        Ruby::Code.new
      when "ps1"
        PS::Code.new
      when "html"
        HTML::Code.new
      when "shell"
        Shell::Code.new
      end
      object_name = parser.get_variable_name("obj")
      parser.instance_variable_set(:@object_variable, object_name)
      variable_types = parser.variable_types
      
      case @example.list_type
      when "method"
        variables = Array.new
        if documentation[:parameters]
          documentation[:parameters].each do |p|
            variables << "#{variable_types[p[:type]]} \"#{p[:name]}\"".to_sym
          end
        end
        # Check if there are documented results from this variable and use them in the syntax
        output = if documentation[:results]
          parser.assign_variable_from_method("#{variable_types[documentation[:results][0][:type]]} #{documentation[:results][0][:name]}", @example.title, variables)
        else
          parser.method(@example.title, variables)
        end
      when "property"
        variable_type = documentation[:value][0][:type].is_a?(Hash) ? variable_types[documentation[:value][0][:type][parser.language_type]] : variable_types[documentation[:value][0][:type]]
        case documentation[:property]
        when :both
          output = parser._comment("Set the property") + "\n"
          output << parser.set_property(@example.title, "#{variable_type} \"#{documentation[:value][0][:name]}\"".to_sym) + "\n"
          output << "\n"
          output << parser._comment("Get the property") + "\n"
          output << parser.get_property(@example.title, "#{variable_type} \"#{documentation[:value][0][:name]}\"".to_sym)
        when :get
          output = parser.get_property(@example.title, "#{variable_type} \"#{documentation[:value][0][:name]}\"".to_sym)
        when :set
          output = parser.set_property(@example.title, "#{variable_type} \"#{documentation[:value][0][:name]}\"".to_sym)
        end
      end
      
      # Split output onto multiple lines if completed string is greater than 56 chars
      if output.length > 56
        new_output = ""
        iteration = 0
        output.chars do |char|
          if char == ',' && iteration >= 50
            new_output << "#{char} _\n"
            iteration = 0
          else
            new_output << char
          end
          iteration += 1
        end
        
        output = new_output
      end
      
      return output
    rescue Exception => e
      logger.error e.inspect
      return "Syntax coming soon."
    end
  end
  
  # get a generic path that can be used to view this example
  def example_default_path(id, language = "")
    example = Example.find(id) if id.is_a? Fixnum
    examples_path :product => example.example_versions.first.product.name, :version => example.example_versions.first.version_start.name, :title => example.title, :language => language
  end
  
  protected
  
  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end
  
  private

  def current_ability
    @user_ip = request.remote_ip if Rails.env.production?
    @current_ability ||= Ability.new(current_user, @user_ip)
  end

  def _reload_libs
    [
      "lib/data_types",
      "lib/code_parser/generic_code",
      "lib/code_parser/asp",
      "lib/code_parser/cf",
      "lib/code_parser/php",
      "lib/code_parser/ps",
      "lib/code_parser/ruby",
      "lib/code_parser/vb",
      "lib/code_parser/vbs",
      "lib/code_parser/shell",
      "lib/code_parser/html",
      "lib/documentation_parser/generic_documentation"
    ].each { |path| require_dependency "#{Rails.root}/#{path}" }
  end
  
  def error_catcher(e)
    ErrorMailer.error_email(e, params, request.env).deliver
    render :template => "/errors/500.html.erb", :status => 500, :layout => false
  end

  def access_denied(e)
    redirect_to root_path, alert: t(:access_denied)
  end

  def missing_template(e)
    redirect_to root_path, alert: t(:missing_template)
  end
end
