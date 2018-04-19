class ErrorMailer < ActionMailer::Base
  default from: "noreply@examples.activepdf.com"
  
  def error_email(error, params = Hash.new, request = Hash.new)
    @error = error
    @params = params
    @request = request
    
    mail :to => "derek.andelin@activepdf.com", :subject => "examples.activepdf.com - Error"
  end
end
