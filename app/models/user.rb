class User < ApplicationRecord
  REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true,
    format: { with: REGEX }, length: { maximum: 30 } 
end
