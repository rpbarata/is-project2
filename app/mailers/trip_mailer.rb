# frozen_string_literal: true

class TripMailer < ApplicationMailer
  def cancel_trip_email(passengers_id, trip_id)
    passengers = User.where(id: passengers_id)
    @trip = Trip.find(trip_id)
    mail(to: passengers.pluck(:email), subject: "Your trip was cancelled")
  end
end
