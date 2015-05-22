class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  validates :body, presence: true, length: { maximum: 2000 }
  scope :recent, -> { order(created_at: :desc) }
end
