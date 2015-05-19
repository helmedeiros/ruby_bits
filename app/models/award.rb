class Award < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  validates :user_id, uniqueness: { scope: :badge_id }
end
