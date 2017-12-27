class User < ActiveRecord::Base
  has_secure_password

  has_many :courses
  has_many :skills
  has_many :experiences
  has_many :projects

  validates :first_name, :last_name, :presence => true,length: { minimum: 2, maximum:100 } #,  uniqueness: { case_sensitive: false },length: { minimum: 5 } 
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  before_create { self.email.downcase! unless self.email.blank? }
end
