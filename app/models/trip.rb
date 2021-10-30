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
  has_many :tickets, dependent: :restrict_with_error
  has_many :users, through: :tickets

  def current_capacity
    capacity - tickets.count
  end

  class << self
    def select_by_date(start_date, end_date)
      if start_date.present? && end_date.present?
        where("departure_time BETWEEN :start_date AND :end_date",
          start_date: start_date.beginning_of_day, end_date: end_date.end_of_day).distinct
      elsif start_date.present?
        where("departure_time > :start_date", start_date: start_date.beginning_of_day).distinct
      elsif end_date.present?
        where("departure_time < :end_date", end_date: end_date.end_of_day).distinct
      else
        all
      end
    end
  end
end
