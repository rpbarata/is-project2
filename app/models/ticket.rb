# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  trip_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tickets_on_trip_id  (trip_id)
#  index_tickets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (trip_id => trips.id)
#  fk_rails_...  (user_id => users.id)
#
class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  # before_destroy :refund_user

  def refund_user
    user.wallet.deposit(trip.price)
  end

  def future_trip?
    trip.departure_time.future?
  end
end
