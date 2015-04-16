class Submission < ActiveRecord::Base
  STATUSES = %w[pending passed failed error].freeze

  belongs_to :activity
  belongs_to :user

  validates :status, inclusion: { in: STATUSES }

  scope :recent, -> { order(created_at: :desc) }

  def passed?; status == 'passed'; end
  def failed?; status == 'failed'; end
end
