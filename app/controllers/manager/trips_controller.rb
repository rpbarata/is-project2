# frozen_string_literal: true

module Manager
  class TripsController < ManagerController
    def index
      start_date = params[:start_date]&.in_time_zone
      end_date = params[:end_date]&.in_time_zone

      @trips = Trip.select_by_date(start_date, end_date).order("departure_time ASC").page(params[:page])
    end

    def new
      @trip = Trip.new
    end

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

    def show
      @trip = Trip.find(params[:id])
      @passengers = @trip.users.page(params[:page])
    end

    def destroy
    end

    private

    def trip_params
      params.require(:trip).permit(:capacity, :departure_point, :departure_time, :destination, :price)
    end
  end
end
