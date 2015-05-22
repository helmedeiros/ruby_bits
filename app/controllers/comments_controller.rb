class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    track  = Track.find_by!(slug: params[:track_id])
    mod    = track.modules.find_by!(slug: params[:module_id])
    lesson = mod.lessons.find_by!(slug: params[:lesson_id])
    lesson.comments.create!(user: current_user, body: params.require(:comment).permit(:body)[:body])
    redirect_to track_module_lesson_path(track, mod, lesson, anchor: 'comments')
  end
end
