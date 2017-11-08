class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  scope :hot, -> {
    joins(:post).select(:post_id).group("likes.post_id").order("count(*) DESC").limit(10)
  }
end
