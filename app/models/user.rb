class User < ApplicationRecord
  has_many :documents
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true,
    format: { with: REGEX }, length: { maximum: 30 } 
  validates :password, length: { minimum: 5  }
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_attribute(:activated , true)
    update_attribute(:activated_at, Time.zone.now)
  end
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  def send_password_reset_digest
    UserMailer.password_reset(self).deliver_now
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at,   Time.zone.now)
  end

  def password_reset_expired?
      reset_sent_at < 2.hours.ago
  end


  private
  def downcase_email
    self.email = email.downcase
  end
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest= User.digest(activation_token)
  end
end
