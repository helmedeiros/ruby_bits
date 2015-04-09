class TracksController < ApplicationController
  def index
    @tracks = Track.order(:position)
  end

  def show
    @track = Track.find_by!(slug: params[:id])
    @modules = @track.modules
  end
end
