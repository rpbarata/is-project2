# frozen_string_literal: true

class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table(:wallets) do |t|
      t.decimal(:balance, precision: 8, scale: 2, default: 0)
      t.references(:user, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
