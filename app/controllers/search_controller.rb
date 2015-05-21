class SearchController < ApplicationController
  def index
    @query = params[:q].to_s.strip
    if @query.length >= 2
      like = "%#{@query}%"
      @lessons = Lesson.where('lower(title) like ? OR lower(body) like ?', like.downcase, like.downcase).limit(30)
      @tracks  = Track.where('lower(name) like ?', like.downcase).limit(10)
    else
      @lessons = Lesson.none
      @tracks  = Track.none
    end
  end
end
