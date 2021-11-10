# frozen_string_literal: true

class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table(:places) do |t|
      t.string(:name)

      t.timestamps
    end
  end
end
