class SnippetsController < ApplicationController
  before_filter :authorize!

  def show
    @snippet = Snippet.find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        render json: @snippet
      }
    end
  end

  private
  def authorize!
    raise "You are not authorized!" unless can?(:manage, Snippet)
  end
end
