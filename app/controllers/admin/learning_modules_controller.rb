module Admin
  class LearningModulesController < BaseController
    before_action :load_track
    before_action :load_module, only: [:edit, :update, :destroy]

    def new;  @module = @track.modules.build; end
    def edit; end

    def create
      @module = @track.modules.build(module_params)
      if @module.save
        redirect_to admin_track_path(@track), notice: 'module created'
      else
        render :new
      end
    end

    def update
      if @module.update(module_params)
        redirect_to admin_track_path(@track), notice: 'updated'
      else
        render :edit
      end
    end

    def destroy
      @module.destroy
      redirect_to admin_track_path(@track), notice: 'deleted'
    end

    private

    def load_track;  @track  = Track.find_by!(slug: params[:track_id]); end
    def load_module; @module = @track.modules.find_by!(slug: params[:id]); end
    def module_params; params.require(:learning_module).permit(:name, :slug, :overview, :position); end
  end
end
