# frozen_string_literal: true

# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  balance    :decimal(8, 2)    default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_wallets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Wallet < ApplicationRecord
  belongs_to :user

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def deposit(value)
    self.balance += value

    save!
  end

  def purchase(value)
    self.balance -= value

    save
  end
end
