class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true,length: {minimum: 5}
  validates :user, presence: true
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  mount_uploader :img, ImageUploader
end
