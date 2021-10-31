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
      logger.info(t("logger.info.bought_trip", user_id: current_user.id, trip_id: trip.id))
      redirect_to(user_tickets_path, notice: t("notice.bought_trip"))
    else
      logger.info(t("logger.error.bought_trip", user_id: current_user.id, trip_id: trip.id))
      redirect_to(trips_path(page: params[:page]), alert: t("alert.bought_trip"))
    end
  end
end
