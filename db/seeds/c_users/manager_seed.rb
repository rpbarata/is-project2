STDOUT.puts("Creating User Manager")

manager = User.where(
  email: ENV["ADMIN_EMAIL"]
).first_or_initialize(
  email: ENV["ADMIN_EMAIL"],
  role: :manager,
  password: ENV["ADMIN_PASSWORD"],
  password_confirmation: ENV["ADMIN_PASSWORD"],
  username: ENV["ADMIN_USERNAME"]
)

if manager.present?
  manager.update(
    email: ENV["ADMIN_EMAIL"],
    role: :manager,
    password: ENV["ADMIN_PASSWORD"],
    password_confirmation: ENV["ADMIN_PASSWORD"],
    username: ENV["ADMIN_USERNAME"]
  )
else
  manager.skip_confirmation!
  manager.save!
end