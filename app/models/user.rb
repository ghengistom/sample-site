require 'bcrypt'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :new_token

  before_save :encrypt_token

  def encrypt_token
    self.token = ::BCrypt::Password.create(new_token).to_s if new_token.present?
  end  
end
