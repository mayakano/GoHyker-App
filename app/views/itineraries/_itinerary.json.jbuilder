json.extract! itinerary, :id, :start_date, :end_date, :available_seat, :projected_eta, :description, :user_id, :created_at, :updated_at
json.url itinerary_url(itinerary, format: :json)
