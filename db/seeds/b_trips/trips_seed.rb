# frozen_string_literal: true

unless Trip.any?
  STDOUT.puts("Seeding DB with 50 random trips")

  place_ids = Place.all.pluck(:id)

  50.times do |_i|
    departure_point_id = place_ids.sample
    destination_point_id = place_ids.sample
    destination_point_id = place_ids.sample while departure_point_id == destination_point_id
    Trip.create!(
      capacity: Faker::Number.between(from: 20, to: 75),
      departure_point_id: departure_point_id,
      departure_time: Faker::Time.between(from: Time.zone.now + 1.day, to: Time.zone.now + 31.days),
      destination_point_id: destination_point_id,
      price: Faker::Number.between(from: 5, to: 50)
    )
  end
end
