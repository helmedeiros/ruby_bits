class SubmissionsController < ApplicationController
  respond_to :json

  def create
    @track    = Track.find_by!(slug: params[:track_id])
    @module   = @track.modules.find_by!(slug: params[:module_id])
    @lesson   = @module.lessons.find_by!(slug: params[:lesson_id])
    @activity = @lesson.activities.find(params[:activity_id])
    authorize @activity, :submit?

    result = ActivityChecker.call(@activity,
                                  source: params[:source],
                                  choice: params[:choice])

    submission = Submission.create!(
      activity:   @activity,
      user:       current_user,
      source:     params[:source],
      choice:     params[:choice],
      status:     result.status,
      stdout:     result.stdout,
      stderr:     result.stderr,
      runtime_ms: result.runtime_ms
    )

    if submission.passed?
      LessonCompletion.evaluate(current_user, @lesson)
      StreakUpdater.touch(current_user)
      BadgeGrantor.evaluate(current_user)
    end

    render json: {
      status:      submission.status,
      stdout:      submission.stdout,
      stderr:      submission.stderr,
      runtime_ms:  submission.runtime_ms,
      hint:        result.hint,
      lesson_done: current_user && current_user.completed?(@lesson),
      streak:      current_user && current_user.current_streak
    }
  end
end
