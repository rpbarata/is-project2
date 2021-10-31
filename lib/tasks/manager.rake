# frozen_string_literal: true

namespace :manager do
  desc "Create new manager"
  task new: :environment do
    print "email: "
    email = STDIN.gets.strip
    print "password: "
    password = STDIN.gets.strip
    print "password_confirmation: "
    password_confirmation = STDIN.gets.strip

    user = User.new(email: email, password: password, password_confirmation: password_confirmation, role: :manager)

    if user.save
      STDOUT.puts "Manager created".green
    else
      STDOUT.puts "Tt was not possible to create the manager: ".red
      if user.errors.any?
        user.errors.full_messages.each do |msg|
          STDOUT.puts "- #{msg}"
        end
      end
    end
  end
end
