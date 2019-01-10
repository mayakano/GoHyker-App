class Itinerary < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar_image
  has_many :locations
  has_many :attendees
  has_many :events,
            foreign_key: 'user_id',
            class_name: 'Itinerary',
            through: :attendees

  scope :search, -> ( term ) { where("description ilike ?", "%#{term}%") }
  scope :between, -> ( start_date, end_date ) do
                       where(
                         "start_date is not null and due_date >= ? and due_date <= ?",
                         start_date, end_date
                       )
                      end

end
