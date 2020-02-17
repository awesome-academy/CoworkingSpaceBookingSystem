class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :name
      t.boolean :status , null: false, default: 0

      t.timestamps
    end
  end
end
