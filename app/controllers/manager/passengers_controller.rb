# frozen_string_literal: true

module Manager
  class PassengersController < ManagerController
    # GET	/manager/passengers
    def index
      @passengers = User.select(:email, :username)
        .joins(:tickets)
        .group(:id)
        .order("COUNT(tickets.id) DESC")
        .first(params[:limit].to_i)
    end
  end
end
