# Named LearningModule because Ruby already has a top-level Module.
class LearningModule < ActiveRecord::Base
  self.table_name = 'learning_modules'

  belongs_to :track
  has_many :lessons, -> { order(:position) }, dependent: :destroy

  validates :name, :slug, presence: true
  validates :slug, uniqueness: { scope: :track_id }

  def to_param
    slug
  end
end
