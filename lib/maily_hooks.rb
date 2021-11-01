# frozen_string_literal: true

passengers_id = User.first.id
trip_id = Trip.first.id

Maily.hooks_for("TripMailer") do |mailer|
  mailer.register_hook(:cancel_trip_email, passengers_id, trip_id)
end
