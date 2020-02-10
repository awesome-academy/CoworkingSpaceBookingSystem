class User < ApplicationRecord
<<<<<<< HEAD
=======
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: {maximum: Settings.name_max}
  validates :phone, presence: true,
                    numericality: true,
                    length: {minimum: Settings.phone_min, maximum: Settings.phone_max}
  validates :password, presence: true, length: {minimum: Settings.password_min},
                    allow_nil: true
  validates :email, presence: true, length: {maximum: Settings.email_max},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  before_save{self.email = email.downcase}
  has_secure_password
>>>>>>> 2098788... View_Edit_Profile
end
