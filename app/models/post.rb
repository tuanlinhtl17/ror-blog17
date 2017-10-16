class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :content, presence: true, length: { minimum: 100 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :img_url, presence: true
end
