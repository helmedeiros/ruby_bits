module Admin
  class TracksController < BaseController
    before_action :load_track, only: [:show, :edit, :update, :destroy]

    def index;  @tracks = Track.order(:position); end
    def new;    @track = Track.new; end
    def edit;   end

    def create
      @track = Track.new(track_params)
      if @track.save
        redirect_to admin_track_path(@track), notice: 'track created'
      else
        render :new
      end
    end

    def update
      if @track.update(track_params)
        redirect_to admin_track_path(@track), notice: 'updated'
      else
        render :edit
      end
    end

    def destroy
      @track.destroy
      redirect_to admin_tracks_path, notice: 'deleted'
    end

    private

    def load_track;   @track = Track.find_by!(slug: params[:id]); end
    def track_params; params.require(:track).permit(:name, :slug, :description, :position); end
  end
end
