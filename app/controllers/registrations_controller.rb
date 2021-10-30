# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

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

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
