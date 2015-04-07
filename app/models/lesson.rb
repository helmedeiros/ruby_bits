class Lesson < ActiveRecord::Base
  belongs_to :learning_module
  has_many :activities, -> { order(:position) }, dependent: :destroy

  validates :title, :slug, presence: true
  validates :slug, uniqueness: { scope: :learning_module_id }

  delegate :track, to: :learning_module

  def to_param
    slug
  end

  def next
    learning_module.lessons.where('position > ?', position).order(:position).first
  end

  def previous
    learning_module.lessons.where('position < ?', position).order(position: :desc).first
  end
end
