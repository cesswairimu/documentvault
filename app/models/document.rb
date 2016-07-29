class Document < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 20 }
  validates :link, presence: true, length: { maximum: 50 }
  validates :tag, presence: true
  validates :department, presence: true
  validates :content, presence: true, length: {minimum: 50 }
  DEPARTMENT_LIST = [ "Operations", "Training", "Marketing" ]
  scope :a, -> { where("department") }
end
