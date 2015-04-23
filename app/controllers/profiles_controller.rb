class ProfilesController < ApplicationController
  def show
    @user = User.find_by!(nickname: params[:id])
    @submissions = @user.submissions.recent.limit(20)
    @passed_count = @user.submissions.where(status: 'passed').count
  end
end
