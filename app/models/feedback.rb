class Feedback < ActiveRecord::Base  
  validate :must_have_either_rating_or_comment
    
  def must_have_either_rating_or_comment
    if rating.nil? && (comment.nil? || comment.empty?)
      errors.add(:comments, "must be entered.")
    end
  end
  
  def self.average_rating_for_example_id(id)
    feedbacks = Feedback.where("content LIKE 'example-#{id}%'")
    feedbacks.map{|f| f.rating }.compact.inject(0.0) {|sum, rating| sum + rating} / feedbacks.map{|f| f.rating }.compact.length
  end
end
