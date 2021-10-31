# frozen_string_literal: true

module Manager
  module ManagerTripHelper
    def format_trip_capacity(trip)
      "#{trip.users.count}/#{trip.capacity}"
    end
  end
end
