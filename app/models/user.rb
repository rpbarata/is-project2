# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string
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

  def formatted_name
    username.presence || email
  end

  def create_wallet
    self.wallet = Wallet.new
  end
end
