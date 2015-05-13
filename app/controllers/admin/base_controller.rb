module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
    layout 'admin'

    private

    def require_admin!
      redirect_to root_path, alert: 'forbidden' unless current_user && current_user.admin?
    end
  end
end
