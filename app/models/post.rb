class Post < ApplicationRecord
  belongs_to :user
  validates :content, length: { minimum: 100 }
  validates :title, length: { maximum: 30 }
end
