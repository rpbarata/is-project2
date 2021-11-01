# frozen_string_literal: true

class DailySummaryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    STDOUT.puts("Executing DailySummaryJob".yellow)
    Rails.logger.info("Executing DailySummaryJob")

    today_trips = Trip.today

    revenue = 0
    today_trips.find_each do |trip|
      revenue += trip.current_revenue
    end

    DailyMailer.summary_email(today_trips.pluck(:id), revenue).deliver_later
  end
end
