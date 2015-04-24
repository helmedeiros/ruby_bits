class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @completed_count = current_user.completions.count
    @passed_count    = current_user.submissions.where(status: 'passed').count
    @recent          = current_user.completions.order(completed_at: :desc).limit(5).includes(lesson: { learning_module: :track })
    @tracks          = Track.order(:position)
  end
end
