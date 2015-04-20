class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :submissions, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true,
                       format: { with: /\A[a-z0-9_]{3,20}\z/i }

  def to_param
    nickname
  end
end
