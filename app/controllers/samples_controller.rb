class SamplesController < ApplicationController
  layout "application_samples"

  def index
    unless user_signed_in?
      redirect_to root_url
    end
  end

  def show
    if params[:page] == "echo"
      @data = Hash.new
      
      # GET
      if request.query_parameters.present?
        data_temp = Hash.new
        request.query_parameters.each do |name, value|
          data_temp[name] = value
        end
        unless data_temp.empty?
          @data["get"] = data_temp
        end
      end

      # POST
      if request.request_parameters.present?
        data_temp = Hash.new
        request.request_parameters.each do |name, value|
          data_temp[name] = value
        end
        unless data_temp.empty?
          @data["post"] = data_temp
        end
      end

      # Cookies
      if cookies.present?
        data_temp = Hash.new
        filtercookie = ["lang", "_apdf-examples_session", "__utma", "__utmc", "__utmz", "__kti", "__ktv"]
        if params.has_key?(:h)
          filterhead = false
        else
          filterhead = true
        end
        cookies.each do |name, value|
          if filterhead == false
            data_temp[name] = value
          else
            if filtercookie.count(name) < 1
              data_temp[name] = value
            end
          end
        end
        unless data_temp.empty?
          @data["cookies"] = data_temp
        end
      end

      # Custom Headers
      if request.headers.present?
        data_temp = Hash.new
        filterheader = ["HTTP_VERSION", "HTTP_HOST", "HTTP_CONNECTION", "HTTP_ACCEPT", "HTTP_USER_AGENT", "HTTP_DNT", "HTTP_ACCEPT_ENCODING", "HTTP_ACCEPT_LANGUAGE", "HTTP_CACHE_CONTROL", "HTTP_IF_NONE_MATCH", "HTTP_COOKIE", "HTTP_ORIGIN", "HTTP_REFERER"]
        filterhead = true
        request.headers.each do |name, value|
          if name.include? 'HTTP_'
            if filterhead == true
              if filterheader.count(name) < 1
                name.tr("HTTP_", "")
                data_temp[name.tr("HTTP_", "")] = value
              end
            end
          end
        end
        unless data_temp.empty?
          @data["headers"] = data_temp
        end
      end

      # Full Headers
      if params.has_key?(:h)
        if request.headers.present?
          data_temp = Hash.new
          request.headers.each do |name, value|
            data_temp[name] = value
          end
          @data["headers"] = data_temp
        end
      end
    end

    render params[:page]

    if params[:page] == "echo"
      # Set a test cookie
      cookies[:Example] = {:value => "Test cookie", :expires => 1.minute.from_now}
    end
  end
end
