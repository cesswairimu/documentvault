class Document < ApplicationRecord
  belongs_to :user
  mount_uploader :attachment,  AttachmentUploader 
  validates :title, presence: true
  validates :link, presence: true, length: { maximum: 50 }, uniqueness:true
  validates :tag, presence: true
  validates :attachment, presence:true
  validates :department, presence: true
  validates :title, :tag, format: { with: /\A[a-zA-Z]+\z/, }
  DEPARTMENT_LIST = [ "Operations", "Training", "Marketing","Computing", "Accounting" ]

  def self.search(search)
    where("title like? OR tag like?",  "%#{search}%", "%#{search}%")
  end
end
