module Manager::ManagerTripHelper
  def format_trip_capacity(trip)
    "#{trip.users.count}/#{trip.capacity}"
  end
end
