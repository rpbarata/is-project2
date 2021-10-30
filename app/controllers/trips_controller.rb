# frozen_string_literal: true

class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips or /trips.json
  def index
    start_date = params[:start_date]&.in_time_zone
    end_date = params[:end_date]&.in_time_zone

    @trips = Trip.select_by_date(start_date, end_date).order("departure_time ASC").page(params[:page])
  end

  # GET /trips/1 or /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips or /trips.json
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to(@trip, notice: "Trip was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /trips/1 or /trips/1.json
  def update
    if @trip.update(trip_params)
      redirect_to(@trip, notice: "Trip was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  # DELETE /trips/1 or /trips/1.json
  def destroy
    @trip.destroy

    redirect_to(trips_url, notice: "Trip was successfully destroyed.")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trip_params
    params.require(:trip).permit(:departure_time, :departure_point, :destination, :capacity, :price)
  end
end
