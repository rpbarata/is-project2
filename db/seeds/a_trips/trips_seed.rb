# frozen_string_literal: true
# == Schema Information
#
# Table name: trips
#
#  id              :bigint           not null, primary key
#  capacity        :integer
#  departure_point :string
#  departure_time  :datetime
#  destination     :string
#  price           :decimal(8, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# 50.times do |_i|
#   Trip.create!(
#     capacity: Faker::Number.between(from: 20, to: 75),
#     departure_point: Faker::Address.city,
#     departure_time: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now + 31),
#     destination: Faker::Address.city,
#     price: Faker::Number.between(from: 5, to: 50)
#   )
# end
