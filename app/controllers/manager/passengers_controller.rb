# frozen_string_literal: true

module Manager
  class PassengersController < ManagerController
    def index
      @passengers = User.joins(:tickets).group(:id).order("COUNT(tickets.id) DESC").first(params[:limit].to_i)
    end
  end
end
