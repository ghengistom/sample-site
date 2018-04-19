class Admin::AdminController < ApplicationController
  before_filter :get_snippets
  
  def get_snippets
    @snippets = Snippet.all
  end
  
end
