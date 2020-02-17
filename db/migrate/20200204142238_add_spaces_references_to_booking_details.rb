class AddSpacesReferencesToBookingDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :booking_details, :space, foreign_key: true
  end
end
