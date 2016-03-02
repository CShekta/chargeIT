class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :ev_id
      t.string :lat
      t.string :long
      t.string :usage_cost
      t.string :phone
      t.string :comments

      t.timestamps null: false
    end
  end
end
