class FeedbackMailer < ActionMailer::Base
  default from: "noreply@examples.activepdf.com"
  
  def feedback_email(feedback)
    @feedback = feedback
    @example = Example.find_by_id(@feedback.content.split('-')[1])
    
    mail :to => "derek.andelin@activepdf.com", :subject => "Feedback: #{@example.title}"
  end
end
