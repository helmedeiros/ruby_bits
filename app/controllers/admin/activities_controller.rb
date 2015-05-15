module Admin
  class ActivitiesController < BaseController
    before_action :load_lesson
    before_action :load_activity, only: [:edit, :update, :destroy]

    def new;  @activity = @lesson.activities.build; end
    def edit; end

    def create
      @activity = @lesson.activities.build(activity_params_with_yaml)
      @activity.save ? to_lesson('activity created') : render(:new)
    end

    def update
      @activity.update(activity_params_with_yaml) ? to_lesson('updated') : render(:edit)
    end

    def destroy
      @activity.destroy
      to_lesson('deleted')
    end

    private

    def load_lesson
      track  = Track.find_by!(slug: params[:track_id])
      mod    = track.modules.find_by!(slug: params[:module_id])
      @lesson = mod.lessons.find_by!(slug: params[:lesson_id])
    end

    def load_activity
      @activity = @lesson.activities.find(params[:id])
    end

    def activity_params_with_yaml
      raw = params.require(:activity).permit(
        :title, :kind, :prompt, :starter_code, :solution, :spec_code,
        :correct_choice, :difficulty, :position, :choices_yaml, :hints_yaml
      )
      attrs = raw.except(:choices_yaml, :hints_yaml)
      attrs[:choices] = YAML.safe_load(raw[:choices_yaml].to_s) || {} if raw[:choices_yaml]
      attrs[:hints]   = YAML.safe_load(raw[:hints_yaml].to_s)   || [] if raw[:hints_yaml]
      attrs
    end

    def to_lesson(msg)
      redirect_to admin_track_module_lesson_path(@lesson.learning_module.track,
                                                 @lesson.learning_module,
                                                 @lesson), notice: msg
    end
  end
end
