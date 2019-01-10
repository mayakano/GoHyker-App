class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :latitude
      t.string :longitude
      t.boolean :is_origin
      t.belongs_to :itinerary, foreign_key: true

      t.timestamps
    end
  end
end
