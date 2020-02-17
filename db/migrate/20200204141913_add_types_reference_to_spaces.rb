class AddTypesReferenceToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :types, :space, foreign_key: true
  end
end
