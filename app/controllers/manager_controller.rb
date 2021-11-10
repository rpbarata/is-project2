# frozen_string_literal: true

class ManagerController < ApplicationController
  before_action :authenticate_manager!

  def authenticate_manager!
    redirect_to(trips_path, alert: t("alert.unauthorized")) unless current_user.manager?
  end
end
