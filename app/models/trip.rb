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

  validates :capacity, numericality: { only_integer: true, greater_than: 0 }, presence: true
  validates :departure_point, presence: true
  validate  :validates_departure_time
  validates :departure_time, presence: true
  validates :destination, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # Why this callback is not working? It is because rails verify the tickets relations before this callback is called?
  # before_destroy :cancel_tickets

  scope :today, -> {
                  where("departure_time BETWEEN :start_date AND :end_date",
                    start_date: Time.zone.now.beginning_of_day,
                    end_date: Time.zone.now.end_of_day)
                }

  # validate  :validates_departure_time
  def validates_departure_time
    if departure_time.present? && departure_time < Time.zone.now
      errors.add(:departure_time, "can't be in the past")
    end
  end

  def current_capacity
    capacity - tickets.count
  end

  # def cancel_tickets
  #   tickets.find_each do |ticket|
  #     ticket.refund_user
  #     ticket.destroy
  #   end
  # end

  def current_revenue
    tickets.count * price
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
