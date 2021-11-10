# frozen_string_literal: true

class ChangeDepartureAndDestinationPointInTrips < ActiveRecord::Migration[6.1]
  def change
    change_table(:trips, bulk: true) do |t|
      reversible do |dir|
        dir.up do
          t.remove(:departure_point)
          t.remove(:destination)
        end
      end

      t.add_reference(:departure_point, foreign_key: { to_table: "places" }, index: true)
      t.add_reference(:destination_point, foreign_key: { to_table: "places" }, index: true)
    end
  end
end
