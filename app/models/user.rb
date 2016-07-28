class User < ApplicationRecord
  attr_accessor :remember_token
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
    return false if remember_digest.nil?:w
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  def forget
    update_attribute(:remember_digest, nil)
  end
end
