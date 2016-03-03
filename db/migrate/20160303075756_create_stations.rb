class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :ev_id
      t.float :lat
      t.float :long
      t.string :title
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip
      t.string :usage_cost
      t.string :phone
      t.string :comments
      t.timestamps null: false
    end
  end
end
