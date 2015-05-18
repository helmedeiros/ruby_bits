class LeaderboardController < ApplicationController
  def index
    @top = User
      .joins(:completions)
      .select('users.*, COUNT(completions.id) AS solved_count')
      .group('users.id')
      .order('solved_count DESC')
      .page(params[:page]).per(20)
  end
end
