class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|
      t.string :start_date
      t.string :end_date
      t.integer :available_seat
      t.string :projected_eta
      t.text :description
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
