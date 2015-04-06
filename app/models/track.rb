class Track < ActiveRecord::Base
  has_many :modules, -> { order(:position) },
           class_name: 'LearningModule',
           dependent: :destroy

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/ }

  def to_param
    slug
  end
end
