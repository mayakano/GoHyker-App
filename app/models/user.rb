class User < ApplicationRecord
  has_secure_password
  has_many :messages
  has_one_attached :avatar_image
  has_many :itineraries
  has_many :attendees
  validates :email, uniqueness: true

end
