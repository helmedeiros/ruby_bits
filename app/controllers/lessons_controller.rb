class LessonsController < ApplicationController
  def show
    @track   = Track.find_by!(slug: params[:track_id])
    @module  = @track.modules.find_by!(slug: params[:module_id])
    @lesson  = @module.lessons.find_by!(slug: params[:id])
  end
end
