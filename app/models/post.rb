class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tag, through: :post_tags

  validates :content, presence: true, length: { minimum: 100 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :img_url, presence: true

  def all_tags=(names)
    self.tag = names.split(", ").map do |name|
        Tag.where(name: name).first_or_create!
    end
  end

  def all_tags
    self.tag.map(&:name).join(", ")
  end
end
