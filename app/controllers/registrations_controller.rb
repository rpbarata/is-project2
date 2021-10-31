# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to(root_path, notice: t("notice.new", record_type: @user.model_name.human.downcase))
      logger.info(t("logger.info.new", record_type: @user.model_name.human, id: @user.id))
    else
      flash.now[:alert] = t("alert.new", record_type: @user.model_name.human.downcase)
      logger.error(t("logger.error.new", record_type: @user.model_name.human))
      render(:new)
    end
  end

  def edit; end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update(user_edit_params)
      redirect_to(edit_profile_path, notice: t("notice.update", record_type: @user.model_name.human.downcase))
      logger.info(t("logger.info.update", record_type: @user.model_name.human, id: @user.id))
    else
      flash.now[:alert] = t("alert.update", record_type: @user.model_name.human.downcase)
      logger.error(t("logger.error.update", record_type: @user.model_name.human, id: @user.id))
      render("edit")
    end
  end

  def destroy
    if @user.destroy
      logger.info(t("logger.info.destroy", record_type: @user.model_name.human, id: @user.id))
      redirect_to(sign_in_path, notice: t("notice.destroy", record_type: @user.model_name.human.downcase))
    else
      logger.error(t("logger.info.destroy", record_type: @user.model_name.human, id: @user.id))
      redirect_to(edit_profile_path, alert: t("alert.destroy", record_type: @user.model_name.human.downcase))
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end

  def set_user
    @user = current_user
  end
end
