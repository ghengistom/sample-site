module ApplicationHelper
  def textilize(text)  
    RedCloth.new(text).to_html unless text.blank?  
  end
end
