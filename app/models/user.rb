# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string
#  role            :integer
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_one :wallet, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :trips, through: :tickets

  VALID_EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :username,  length: { maximum: 50 }, if: -> { username.present? }
  validates :password,  presence: true, length: { within: 6..40 }, on: :create
  validates :password, length: { within: 6..40 },
                        on: :update,
                        unless: lambda { |user| user.password.blank? }
  validates :email,     presence: true
  validates :email,     length: { maximum: 260 },
                        format: { with: VALID_EMAIL_FORMAT },
                        uniqueness: { case_sensitive: false },
                        if: -> { email.present? }

  before_save { self.email = email.downcase }
  before_save :create_wallet
  before_save :set_default_role

  enum role: { manager: 1, passenger: 2 }

  def formatted_name
    username.presence || email
  end

  # before_save
  def create_wallet
    self.wallet = Wallet.new
  end

  # before_save
  def set_default_role
    if role.blank?
      self.role = :passenger
    end
  end

  def buy_trip(trip)
    success = false
    ActiveRecord::Base.transaction do
      ticket = Ticket.new
      ticket.user = self
      ticket.trip = trip

      if (success = wallet.purchase(trip.price))
        success = ticket.save!
      end
    end
    success
  end

  def get_ticket(trip)
    tickets.find_by(trip: trip)
  end
end
