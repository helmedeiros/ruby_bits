class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :submissions, dependent: :destroy
  has_many :completions, dependent: :destroy
  has_many :completed_lessons, through: :completions, source: :lesson

  validates :nickname, presence: true, uniqueness: true,
                       format: { with: /\A[a-z0-9_]{3,20}\z/i }

  def admin?
    !!admin
  end

  def completed?(lesson)
    completions.exists?(lesson_id: lesson.id)
  end

  def to_param
    nickname
  end
end
