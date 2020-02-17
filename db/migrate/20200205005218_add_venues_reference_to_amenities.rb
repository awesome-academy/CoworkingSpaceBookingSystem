class AddVenuesReferenceToAmenities < ActiveRecord::Migration[5.2]
  def change
    add_reference :amenities, :venue, foreign_key: true
  end
end
