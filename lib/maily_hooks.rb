# frozen_string_literal: true

passengers_id = User.first.id
trip_id = Trip.first.id
Maily.hooks_for("TripMailer") do |mailer|
  mailer.register_hook(:cancel_trip_email, passengers_id, trip_id)
end

trips_ids = Trip.all.pluck(:id)
revenue = 100
Maily.hooks_for("DailyMailer") do |mailer|
  mailer.register_hook(:summary_email, trips_ids, revenue)
end
