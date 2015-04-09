class LearningModulesController < ApplicationController
  def show
    @track   = Track.find_by!(slug: params[:track_id])
    @module  = @track.modules.find_by!(slug: params[:id])
    @lessons = @module.lessons
  end
end
