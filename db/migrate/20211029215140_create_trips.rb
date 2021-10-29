# frozen_string_literal: true

class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table(:trips) do |t|
      t.datetime(:departure_time)
      t.string(:departure_point)
      t.string(:destination)
      t.integer(:capacity)
      t.decimal(:price, precision: 8, scale: 2)

      t.timestamps
    end
  end
end
