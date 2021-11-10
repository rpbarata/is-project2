# frozen_string_literal: true

class AddDepartureTimeIndexToTrips < ActiveRecord::Migration[6.1]
  def change
    add_index(:trips, :departure_time)
  end
end
