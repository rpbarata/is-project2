# frozen_string_literal: true

json.extract!(trip, :id, :departure_time, :departure_point, :destination, :capacity, :price, :created_at, :updated_at)
json.url(trip_url(trip, format: :json))
