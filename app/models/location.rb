class Location < ApplicationRecord
  belongs_to :itinerary
  scope :origin, -> { find_by_is_origin(true) }
  scope :destination, -> { find_by_is_origin(false) }

  # def get_coords
  #   results = Geocoder.search( self.address )
  #   self.latitude = results[0].data["lat"]
  #   self.longitude = results[0].data["lon"]

  #   self.save

  # end
end
