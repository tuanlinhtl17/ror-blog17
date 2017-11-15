class Message < ApplicationRecord
  belongs_to :sender, required: false, class_name: "User"
  belongs_to :receiver, required: false, class_name: "User"
  validates :content, presence: true
  validates :user_send, presence: true
  validates :user_receive, presence: true
  # scope :for_display, -> { order(:created_at).last(50) }
end
