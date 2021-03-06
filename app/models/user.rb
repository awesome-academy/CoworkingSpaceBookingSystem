class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  attr_accessor :remember_token, :activation_token, :reset_token
  validates :name, presence: true, length: {maximum: Settings.name_max}
  validates :phone, presence: true,
                    numericality: true,
                    length: {minimum: Settings.phone_min, maximum: Settings.phone_max}
  validates :password, presence: true, length: {minimum: Settings.password_min},
                    allow_nil: true
  validates :email, presence: true, length: {maximum: Settings.email_max},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  before_save :downcase_email
  before_create :create_activation_digest
  has_secure_password
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
          BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    User.update(remember_digest: User.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    User.update(remember_digest: nil)
  end

  def activate
    User.update(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    User.update(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def password_reset_expired?
    reset_sent_at < Settings.password_expired.hours.ago
  end
end
