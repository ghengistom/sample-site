class ExamplesController < ApplicationController
  before_filter :set_page_id
  before_filter :validate_params, :only => [:download, :show, :documentation, :download_all, :download_all_examples]
  before_filter :get_example_details, :only => [:download, :show, :documentation, :download_all]

  skip_before_action :verify_authenticity_token, only: :search
  
  respond_to :zip, :only => :download
  
  def non_admin_example_access?
    if @example
      # Send the user to the examples index path if they are trying to access an example that is not active
      unless can?(:read, @example)
        # redirect_to root_path, :notice => "I'm sorry, that example is not available."
        raise CanCan::AccessDenied
      end
    end
  end
  
  def set_page_id
   @page_id = "examples"
  end
  
  def show_id
    begin
      redirect_to example_default_path(params[:id].to_i, params[:language])
    rescue
      redirect_to examples_index_path, :notice => "I'm sorry that example was not found."
    end
  end
  
  def get_documentation_details
    @documentation = parse_generic_documentation(@example.documentation, @language) if @example && @example.documentation
    if @documentation && (@example.list_type == "method" || @example.list_type == "property")
      @syntax = parse_generic_documentation_syntax(@documentation, @language)
    end
  end
  
  def index
    @active = Product.active
    @future = Product.future
  end
  
  def legacy
    @active = Product.active
    @future = Product.future
    @legacy = Product.legacy
  end

  def get_all_snippets(snippet_list, snippet_exclude_list)
    # puts "Snippet list: #{snippet_list.inspect}"
    # puts "Snippet exclude list: #{snippet_exclude_list.inspect}"
    
    snippets = Hash.new
    snippet_list.each do |sc|
      sc = Category.find(sc)
      Category.where(:id => sc).each do |c|
        snippets[sc] = Array.new unless snippets.include?(sc)
        snippets[sc] = Snippet.find_all_by_product_id_and_version_sort_order_and_category_id(@product.id, @version.sort_order, sc).collect {|s| [s.name, s.id] }

      end
    end
    
    # remove snippets that are excluded from snippet hash
    unless snippet_exclude_list.empty?
      snippets.each do |c,s|
        s.delete_if {|s| snippet_exclude_list.include?(s[1])}
      end
      snippets.delete_if {|c,s| s.length <= 1}
    end
    
    return snippets
  end
  
  def show
    non_admin_example_access?
    
    if @example
      @example_related = Hash.new
      @example_related[:methods] = @example.find_related_tags.is_method
      @example_related[:properties] = @example.find_related_tags.is_property
      @example_related[:advanced] = @example.find_related_tags.is_advanced
    end
    
    @products = Product.order("name ASC")
    
    # Setup feedback form
    @feedback = Feedback.new
        
    if @example
      if @language == "json"
        # parsed_code = parse_generic_code(@example.code, "cs")
        # json_code = {:status => "success", :body => parsed_code[:code]}
        json_code = {:status => "success"}
        parsed_code = parse_generic_code(@example.code, "cs")
        json_code[:cs] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "vb")
        json_code[:vb] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "vbs")
        json_code[:vbs] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "asp")
        json_code[:asp] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "php")
        json_code[:php] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "cfm")
        json_code[:cfm] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "rb")
        json_code[:rb] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "ps1")
        json_code[:ps1] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "shell")
        json_code[:shell] = parsed_code[:code]
        parsed_code = parse_generic_code(@example.code, "html")
        json_code[:html] = parsed_code[:code]

        render :json => json_code
      else
        if params.has_key?(:json)
          @ValidExample = false
          case @language
          when "cs"
            if @example.cs
              @ValidExample = true
            end    
          when "vb"
            if @example.vb
              @ValidExample = true
            end
          when "vbs"
            if @example.vbs
              @ValidExample = true
            end
          when "asp"
            if @example.asp
              @ValidExample = true
            end
          when "php"
            if @example.php
              @ValidExample = true
            end
          when "cfm"
            if @example.cfm
              @ValidExample = true
            end
          when "rb"
            if @example.rb
              @ValidExample = true
            end
          when "ps1"
            if @example.ps1
              @ValidExample = true
            end
          when "shell"
            if @example.shell
              @ValidExample = true
            end
          when "html"
            if @example.html
              @ValidExample = true
            end
          end

          if @ValidExample
            parsed_code = parse_generic_code(@example.code, @language)
            json_code = {:status => "success", :body => parsed_code[:code]}
          else
            json_code = {:status => "success", :body => "#{@language} is not available with this example."}
          end
          render :json => json_code
        else
          parsed_code = parse_generic_code(@example.code, @language)

          @code = parsed_code[:code]
          @error = parsed_code[:error]
          @code_file = parsed_code[:code_file]
          @code_aspx = parsed_code[:code_aspx]
          @portal_aspx = parsed_code[:portal_aspx] if @product.name == "Portal"

          if parsed_code[:snippets] && !parsed_code[:snippets].empty?
            @snippet_categories = get_all_snippets(parsed_code[:snippets], parsed_code[:snippets_to_exclude])
            @snippet_categories_selected = parsed_code[:snippets_to_use].empty? ? parsed_code[:snippets_in_use] : parsed_code[:snippets_to_use]
            @snippets_defaults = parsed_code[:snippets_defaults]
          end

          @title_full = "#{@example.title}: ActivePDF #{@product.name} - #{Example.full_language_name_by_shortname[@language]} Code" # set page title
          @meta_description = "#{@example.title} example written in #{Example.full_language_name_by_shortname[@language]} for ActivePDF #{@product.name} #{@version.name}."
          @meta_keywords = "#{@example.title}, ActivePDF #{@product.name}, ActivePDF #{@product.name} example, #{@product.name}, #{@product.name} #{@version.name}"
        end
      end
    else
      respond_to do |format|
        format.html
        format.json {
          output = []
          examples = []
          examples << @examples_advanced.is_original
          examples << @examples_functions.is_original
          examples.flatten.each do |e|
            @example = e # parse_generic_code requires @example be set
            
            # get a list of snippet categories in use for this example
            parsed_code = parse_generic_code(e.code, 'cs')

            if parsed_code[:snippets] && !parsed_code[:snippets].empty?
              # we found snippets, let's get all the categories, and options
              all_snippets = get_all_snippets(parsed_code[:snippets], parsed_code[:snippets_to_exclude])
              snippet_categories = Hash.new{|h,k| h[k]= Array.new}
              all_snippets.each do |cat,snips|
                snippet_categories["snippets[#{cat.id}]"] = snips.map{|x|x[1]}
              end
              
              # voodoo magic to get all combinations of snippets
              ary = snippet_categories.map {|k,v| [k].product v}
              ary.shift.product(*ary).map {|a| Hash[a]}.each do |combination|
                # get the url for an example, with the combination of snippets
                options = {:product => @product.name, :version => @version.name, :title => e.title, :language => nil}.merge(combination)
                output << examples_url(options)
              end
              

            else
              # no snippets
              output << examples_url(:product => @product.name, :version => @version.name, :title => e.title, :language => nil)
            end
          end
          render :json => output
        }
      end
    end
  end
  
  def search
    tags = params[:t].split(',') if params[:t]
    
    if params[:q]
      @by_title = Example.where("title LIKE ?", "%#{params[:q]}%").is_active
      @by_title = @examples.tagged_with(tags) if tags
      
      @by_tags = Example.tagged_with(params[:q].split(' '))
      
      @examples = @by_title.concat(@by_tags)
      
      Category.where("name LIKE ?", "%#{params[:q]}%").each do |c|
        c.examples.each do |e|
          @examples << e
        end
      end
      
      @examples.uniq!
      @term = params[:q]
      @language = params[:language].empty? ? "cs" : params[:language]
    else
      @examples = []
    end
  end
  
  def download
    non_admin_example_access?

    begin
      parsed_code = parse_generic_code(@example.code, params[:language])
      code = parsed_code[:code]

      attachments = Array.new
      # For each snippet that is used, pull in their attachments
      parsed_code[:snippets_in_use].each do |sid|
        attachments << Snippet.find(sid).attachments
      end
    
      # Pull in the parent clone's attachments
      attachments << @example.cloned_attachments unless @example.cloned_attachments.empty?
    
      # For any files that were used inside the code, get those attachments too.
      parsed_code[:files].each do |file|
        attachments << Attachment.where(["LOWER(file_file_name) = LOWER(?)", file])
      end
    
      attachments.flatten!
      attachments.uniq!
    
      # Zip the download files
      send_data Zippy.new{|zip|
        if @product.name == "Portal"
          zip["#{@example.title.gsub(" ", "_")}.aspx.#{params[:language]}"] = code
          zip["#{@example.title.gsub(" ", "_")}.aspx"] = parsed_code[:portal_aspx]
        else
          if parsed_code[:code_file]
            if parsed_code[:code_aspx]
              add_aspx = ".aspx"
            else
              add_aspx = ""
            end
            zip["#{@example.title.gsub(" ", "_")}#{add_aspx}.#{params[:language]}"] = parsed_code[:code_file]
          end
          zip["#{@example.title.gsub(" ", "_")}.aspx"] = parsed_code[:code_aspx] if parsed_code[:code_aspx]
          zip["#{@example.title.gsub(" ", "_")}.#{params[:language]}"] = code unless parsed_code[:code_file]
        end
        attachments.each do |a|
          if File.file?(a.file.path)
            if a.file_file_name == "RPweb.config" && params[:language] == "html"

            else
              original_filename = a.file.original_filename
              if a.file_file_name == "RPweb.config"
                original_filename = original_filename.gsub("RPweb.config", "web.config")
              end
              zip[original_filename] = File.open(a.file.path)
            end
          end 
        end
      }.data, :type => "application/zip", :filename => @example.title.gsub(" ", "_") + ".#{params[:language]}.zip"

    rescue => e
      logger.error "Handled Error: #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}\n\n"
      redirect_to examples_index_path, :notice => "I'm sorry that example was not found."
    end
  end

  def download_package
    non_admin_example_access?

    begin
      @product = Product.find_by_lowercase_name(params[:product].downcase)
      @version = Version.find_by_product_id_and_lowercase_name(@product.id, params[:version])
      @language = params[:language]
      @examples = Example.find_all_by_product_id_and_version_sort_order(@product.id, @version.sort_order)

      send_data Zippy.new{|zip|
        @examples.each do |ex|
          unless ex.cloned
            @example = ex
            parsed_code = parse_generic_code(ex.code, @language)
            code = parsed_code[:code]
            attachments = Array.new
            # For each snippet that is used, pull in their attachments
            if parsed_code[:snippets_in_use]
              parsed_code[:snippets_in_use].each do |sid|
                attachments << Snippet.find(sid).attachments
              end
            end
          
            # Pull in the parent clone's attachments
            attachments << ex.cloned_attachments unless ex.cloned_attachments.empty?
          
            # For any files that were used inside the code, get those attachments too.
            if parsed_code[:files]
              parsed_code[:files].each do |file|
                attachments << Attachment.where(["LOWER(file_file_name) = LOWER(?)", file])
              end
            end
          
            attachments.flatten!
            attachments.uniq!
        
            if @product.name == "Portal"
              zip["#{ex.title.gsub(" ", "_")}.aspx.#{params[:language]}"] = code
              zip["#{ex.title.gsub(" ", "_")}.aspx"] = parsed_code[:portal_aspx]
            else
              if parsed_code[:code_file]
                if parsed_code[:code_aspx]
                  add_aspx = ".aspx"
                else
                  add_aspx = ""
                end
                zip["#{ex.title.gsub(" ", "_")}#{add_aspx}.#{params[:language]}"] = parsed_code[:code_file]
              end
              zip["#{ex.title.gsub(" ", "_")}.aspx"] = parsed_code[:code_aspx] if parsed_code[:code_aspx]
              zip["#{ex.title.gsub(" ", "_")}.#{params[:language]}"] = code unless parsed_code[:code_file]
            end
            attachments.each do |a|
              if File.file?(a.file.path)
                if a.file_file_name == "RPweb.config" && params[:language] == "html"
                  
                else
                  original_filename = a.file.original_filename
                  if a.file_file_name == "RPweb.config"
                    original_filename = original_filename.gsub("RPweb.config", "web.config")
                  end
                  zip[original_filename] = File.open(a.file.path)
                end
              end 
            end
          end
        end
      }.data, :type => "application/zip", :filename => @product.name.gsub(" ", "_") + ".#{@version.name}" + ".#{params[:language]}.zip"

    rescue => e
      logger.error "Handled Error: #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}\n\n"
      redirect_to examples_index_path, :notice => "I'm sorry that example was not found."
    end
  end
  
  def documentation
    get_documentation_details
    
    @docsOnly = true
    
    if @documentation
      render :layout => false
    else
      render :text => "I'm sorry, that documentation was not found.", :status => :not_found
    end
  end
  
  def download_all
    files = Hash.new
    
    @example.languages.each do |lang|
      # for each language example supports
      # get the code and add each permutation to the download
      parsed_code = parse_generic_code(@example.code, lang[1])
      if parsed_code[:snippets].empty?
        files["#{@example.title.gsub(' ','_')}.#{lang[1]}"] = parsed_code[:code]
      else
        # execute each snippet
        snippet_categories = get_all_snippets(parsed_code[:snippets], parsed_code[:snippets_to_exclude])
        snippet_categories.each do |sc|
          sc[1].each do |s|
            options = {:snippets => {sc[0].id.to_s => s[1].to_s}}
            files["#{@example.title.gsub(' ','_')}-#{s[0].gsub(' ','_')}.#{lang[1]}"] = parse_generic_code(@example.code, lang[1], options)[:code]
          end
        end
      end
    end
    
    send_data Zippy.new{|zip|
      files.each do |n,c|
        zip[n] = c
      end
      Attachment.all.each do |a|
        if File.file?(a.file.path)
          zip[a.file.original_filename] = File.open(a.file.path)
        end
      end
    }.data, :type => "application/zip", :filename => @example.title.gsub(" ", "_") + "-all.zip"
  end

  def download_all_examples
    @product = Product.find_by_lowercase_name(params[:product])
    @version = Version.find_by_product_id_and_lowercase_name(@product.id, params[:version])
    @language = params[:language]
    @examples = Example.find_all_by_product_id_and_version_sort_order(@product.id, @version.sort_order)
    
    send_data Zippy.new{|zip|
      @examples.each do |e|
        unless e.cloned
          @example = e
          code = parse_generic_code(e.code, @language)
          filename = if @product.name == "Portal"
            zip["#{e.title.gsub(" ", "_")}.aspx"] = code[:portal_aspx]
            "#{e.title.gsub(" ", "_")}.aspx"
          else
            "#{e.title.gsub(" ", "_")}"
          end
          zip["#{filename}.#{@language}"] = code[:code] unless code[:code] == "Example coming soon."
          
          puts code[:error] if code[:error]
        end
      end
      
      Attachment.all.each do |a|
        zip[a.file.original_filename] = File.open(a.file.path)
      end
      
    }.data, :type => "application/zip", :filename => @product.name.gsub(" ", "_") + "-#{Time.now.strftime("%Y-%m-%d")}.#{@language}.zip"
  end
  
  private
  def validate_params
    [:product, :version, :title, :language].each do |p|
      params[p] = params[p].downcase.gsub("_", " ") if params[p]
    end
  end

  def get_example_details
    begin
      @product = Product.find_by_lowercase_name(params[:product])
      @version = params[:version] ? Version.find_by_product_id_and_lowercase_name(@product.id, params[:version]) : @product.latest_version
      examples = Example.find_all_by_product_id_and_version_sort_order(@product.id, @version.sort_order)
      @examples_advanced = examples.is_advanced
      @examples_advanced = @examples_advanced.is_active unless current_user && (current_user.admin? || current_user.qa?)
      @examples_advanced = @examples_advanced.is_qa if current_user && current_user.qa?
      @examples_functions = examples.is_not_advanced
      @examples_functions = @examples_functions.is_active unless current_user && (current_user.admin? || current_user.qa?)
      @examples_functions = @examples_functions.is_qa if current_user && current_user.qa?
      @example = params[:title] ? Example.find_by_product_id_and_version_and_title(@product.id, @version, params[:title]) : nil
      
      if params.has_key?(:code) || params.has_key?(:json)
        # if the code or json parameter exists leave the language as what it says in the URL
        @language = params[:language]
      else
        @language = if cookies[:lang]
                      if params[:language]
                        params[:language]
                      else
                        cookies[:lang]
                      end
                    else
                      params[:language] ? params[:language] : @example.languages.each_value.first if @example
                    end
        cookies[:lang] = @language unless @language.nil? || @language.empty? || @language == "json"
        if @language != "json"
          @language = @example.languages.each_value.first unless @example.nil? || @example.languages.has_value?(@language)
          @language = "cs" if @language.nil?
        end
      end
    rescue => e
      logger.error e.message
      logger.error e.backtrace.join("\n")
      return redirect_to examples_index_path(), :notice => "I'm sorry that example was not found."
    end
  end

end
