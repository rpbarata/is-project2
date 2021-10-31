# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to(root_path, notice: "Successfully created account")
    else
      flash.now[:alert] = "Unable to create account"
      render(:new)
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update(user_edit_params)
      redirect_to(edit_profile_path, notice: "Your profile has been updated")
    else
      flash.now[:alert] = "Unable to update your profile"
      render("edit")
    end
  end

  def destroy
    @user = current_user

    if @user.destroy
      redirect_to(sign_in_path,
        notice: "Your account has been deleted successfully.")
    else
      redirect_to(edit_profile_path, alert: "It was not possible to delete your account.")
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
