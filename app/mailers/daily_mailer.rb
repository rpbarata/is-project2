# frozen_string_literal: true

class DailyMailer < ApplicationMailer
  def summary_email(trips_ids, revenue)
    @trips = Trip.where(id: trips_ids)
    @revenue = revenue
    @num_trips = @trips.count
    managers = User.manager
    mail(to: managers.pluck(:email), subject: "Daily Summary")
  end
end
