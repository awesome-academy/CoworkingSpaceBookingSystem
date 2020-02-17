class AddAddressesReferenceToVenues < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :venue, foreign_key: true
  end
end
