class Post < ApplicationRecord
  belongs_to :user

	mount_uploader :image, ImageUploader
	validates :image, presence: true
	validates :title, presence: true, length: { maximum: 15 }
	validates :text, presence: true, length: { maximum: 255 }

	has_many :like, dependent: :destroy
  has_many :likers, through: :like , source: :user

	has_many :comments, dependent: :destroy
end
