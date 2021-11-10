# frozen_string_literal: true

module Manager
  class TripsController < ManagerController
    before_action :set_trip, only: [:show, :destroy]

    # GET	/manager/trips
    def index
      start_date = params[:start_date]&.in_time_zone
      end_date = params[:end_date]&.in_time_zone

      @trips =
        Trip.select(:departure_time, :departure_point_id, :destination_point_id, :price, :capacity, :id)
          .includes([:users, :tickets])
          .select_by_date(start_date, end_date)
          .order(departure_time: :asc)
          .page(params[:page])
    end

    # GET	/manager/trips/new
    def new
      @trip = Trip.new
      @places = Place.all.order(name: :asc)
    end

    # POST	/manager/trips
    def create
      @trip = Trip.new(trip_params)

      if @trip.save
        redirect_to(manager_trips_path, notice: t("notice.new", record_type: @trip.model_name.human.downcase))
        logger.info(t("logger.info.new", record_type: @trip.model_name.human, id: @trip.id))
      else
        flash.now[:alert] = t("alert.new", record_type: @trip.model_name.human.downcase)
        logger.error(t("logger.error.new", record_type: @trip.model_name.human))
        render(:new)
      end
    end

    # GET	/manager/trips/:id(
    def show
      @passengers = @trip.users.page(params[:page])
    end

    # DELETE	/manager/trips/:id
    def destroy
      if @trip.departure_time.future?
        success = false
        passengers_id = @trip.users.pluck(:id)
        trip_id = @trip.id

        ActiveRecord::Base.transaction do
          @trip.tickets.find_each do |ticket|
            ticket.refund_user
            ticket.destroy
          end
          success = @trip.destroy
        end

        if success
          TripMailer.cancel_trip_email(passengers_id, trip_id).deliver_later if passengers_id.present?
          redirect_to(manager_trips_path, notice: "Trip cancelled")
        else
          redirect_to(manager_trips_path, alert: "Unable to cancel trip")
        end
      else
        redirect_to(manager_trips_path(params[:page]), alert: "Unable to cancel trip")
      end
    end

    private

    def trip_params
      params.require(:trip).permit(:capacity, :departure_point_id, :departure_time, :destination_point_id, :price)
    end

    def set_trip
      @trip = Trip.find(params[:id])
    end
  end
end
