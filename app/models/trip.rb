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
class Trip < ApplicationRecord
end
