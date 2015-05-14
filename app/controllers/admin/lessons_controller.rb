module Admin
  class LessonsController < BaseController
    before_action :load_module
    before_action :load_lesson, only: [:edit, :update, :destroy]

    def new;  @lesson = @module.lessons.build; end
    def edit; end

    def create
      @lesson = @module.lessons.build(lesson_params)
      @lesson.save ? redirect_to(admin_track_module_path(@module.track, @module), notice: 'lesson created') : render(:new)
    end

    def update
      @lesson.update(lesson_params) ? redirect_to(admin_track_module_path(@module.track, @module), notice: 'updated') : render(:edit)
    end

    def destroy
      @lesson.destroy
      redirect_to admin_track_module_path(@module.track, @module), notice: 'deleted'
    end

    private

    def load_module; @module = LearningModule.joins(:track).where(tracks: { slug: params[:track_id] }).find_by!(slug: params[:module_id]); end
    def load_lesson; @lesson = @module.lessons.find_by!(slug: params[:id]); end
    def lesson_params; params.require(:lesson).permit(:title, :slug, :body, :position); end
  end
end
