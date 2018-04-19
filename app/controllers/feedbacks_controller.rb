class FeedbacksController < ApplicationController
  require "net/http"
  require "uri"
  
  def verify_google_recptcha(secret_key, response)
    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{response}")
    status = Net::HTTP.get_response(uri)
    hash = JSON.parse(status.body)
    hash["success"] == true ? true : false
  end  
  
  def create
    begin
      @feedback = Feedback.new(feedback_params)
    rescue
      flash[:feedback] = "Unknown Error."
      return_error
    end

    recaptcha_check = verify_google_recptcha("6LcbeRgUAAAAAOJt38anIfN3x6vdNVu0HAVC2hZb", params["g-recaptcha-response"])
    if @feedback && recaptcha_check == true
      if @feedback.save
        FeedbackMailer.feedback_email(@feedback).deliver
        flash[:feedback] = "Thank you for your feedback."
        respond_to do |format|
          format.html {
            redirect_to params[:redirect]
          }
          format.js
        end
      else
        error_generic
      end
    else
      error_humancheck
    end
  end

  private

  def error_generic
    flash[:feedback] = "I'm sorry, your feedback was not saved correctly. Please try again."
    return_error
  end

  def error_humancheck
    flash[:feedback] = "Human check failed. Please try again."
    return_error
  end

  def return_error
    respond_to do |format|
      format.html {
        params[:redirect] ||= examples_index_path
        redirect_to params[:redirect]
      }
      format.js
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit(:content, :from_name, :from_email, :comment)
  end
end
