class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, class_name: "User"
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, class_name: "User"

  validates :content, presence: true, length: { minimum: 100 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :img_url, presence: true

  scope :search, -> (query){
    where("content like ? or title like ?", "%#{query}%", "%#{query}%")
  }

  def all_tags=(names)
    self.tags = names.split(", ").map do |name|
      Tag.where(name: name).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

end
