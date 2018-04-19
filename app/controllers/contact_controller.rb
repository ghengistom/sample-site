class ContactController < ApplicationController
  def create
    ContactMailer.contact_email(params[:name], params[:fields]).deliver
    render json: {status: "ok"}
  end
end