class AddVenuesReferenceToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :spaces, :venue, foreign_key: true
  end
end
