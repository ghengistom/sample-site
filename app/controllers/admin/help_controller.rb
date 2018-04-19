class Admin::HelpController < Admin::AdminController

  def index
    authorize! :manage, Example
    @title = "#{params[:type]} README.rb"
    @code = case params[:type]
    when "docs"
      IO.read("#{Rails.root}/lib/documentation_parser/README.rb")
    else
      IO.read("#{Rails.root}/lib/code_parser/help/README.rb")
    end
  end

end
