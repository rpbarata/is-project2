# frozen_string_literal: true

namespace :dev do
  desc "Populate db with trips"
  task generate_trips: :environment do
    50.times do |_i|
      Trip.create!(
        capacity: Faker::Number.between(from: 20, to: 75),
        departure_point: Faker::Address.city,
        departure_time: Faker::Time.between(from: Time.zone.now + 1.day, to: Time.zone.now + 1.month),
        destination: Faker::Address.city,
        price: Faker::Number.between(from: 5, to: 50)
      )
    end
  end
end
