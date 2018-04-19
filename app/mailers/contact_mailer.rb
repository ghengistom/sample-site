class ContactMailer < ActionMailer::Base
  default from: "requestacall@activepdf.com"
  
  def contact_email(name, fields)
    @name = name
    @fields = fields
    mail :to => "sales@activepdf.com", :subject => name
  end
end
