class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  private

  def forbidden
    respond_to do |fmt|
      fmt.html { redirect_to new_user_session_path, alert: 'sign in to continue' }
      fmt.json { render json: { error: 'forbidden' }, status: :forbidden }
    end
  end
end
