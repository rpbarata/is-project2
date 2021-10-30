# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to(root_path, notice: "Logged in successfully")
    else
      flash.now[:alert] = "Invalid email or password"
      render(:new)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(sign_in_path, notice: "Logged Out")
  end
end
