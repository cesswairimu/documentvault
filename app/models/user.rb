class User < ApplicationRecord
  has_many :documents
  attr_accessor :remember_token, :activation_token
  before_save :email_downcase
  before_create :activation_digest
  REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 20 }
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
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  def forget
    update_attribute(:remember_digest, nil)
  end
  private
  def email_downcase
    self.email = email.downcase
  end
  def activation_digest
    self.activation_token = User.new_token
    self.activation_digest= User.digest(activation_token)
  end


end
