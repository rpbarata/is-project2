# frozen_string_literal: true

module Manager
  module ManagerTripHelper
    def format_trip_capacity(trip)
      "#{trip.users.size}/#{trip.capacity}"
    end
  end
end
