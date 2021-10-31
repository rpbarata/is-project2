# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      logger.info(t("logger.info.signed_in", id: user.id))
      redirect_to(root_path, notice: t("notice.signed_in"))
    else
      flash.now[:alert] = t("alert.signed_in")
      logger.error(t("logger.error.signed_in"))
      render(:new)
    end
  end

  def destroy
    logger.info(t("logger.info.signed_in", id: current_user.id))
    session[:user_id] = nil
    redirect_to(sign_in_path, notice: t("notice.signed_out"))
  end
end
