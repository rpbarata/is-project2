# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "traveler@mail.com"
  layout "mailer"
end
