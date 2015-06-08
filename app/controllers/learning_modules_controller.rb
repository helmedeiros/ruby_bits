class LearningModulesController < ApplicationController
  def show
    @track   = Track.find_by!(slug: params[:track_id])
    @module  = @track.modules.find_by!(slug: params[:id])
    @lessons = @module.lessons.includes(:activities)
    @presented = @lessons.map { |l| LessonPresenter.new(l, current_user) }
  end
end
