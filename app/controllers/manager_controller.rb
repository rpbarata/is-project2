class ManagerController < ApplicationController
  before_action :authenticate_manager!

  def authenticate_manager!
    redirect_to(trips_path, alert: "You are not authorized to access this page.") unless current_user.manager?
  end

end
