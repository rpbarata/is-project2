# frozen_string_literal: true

class TripsController < ApplicationController
  # GET /trips
  def index
    start_date = params[:start_date]&.in_time_zone
    end_date = params[:end_date]&.in_time_zone

    @trips = Trip.select_by_date(start_date, end_date).order("departure_time ASC").page(params[:page])
  end

  # PATCH /buy_trip
  def buy_trip
    trip = Trip.find(params[:id])

    if current_user.buy_trip(trip)
      redirect_to(trips_path, notice: "Congratulations! You bought a trip.")
    else
      redirect_to(trips_path, alert: "It was not possible to buy the trip.")
    end
  end
end
