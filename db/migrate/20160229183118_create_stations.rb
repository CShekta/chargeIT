class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :ev_id
      t.string :integer
      t.string :name
      t.string :string
      t.string :icon
      t.string :string
      t.string :lat
      t.string :float
      t.string :long
      t.string :float
      t.string :description
      t.string :string
      t.string :score
      t.string :float
      t.string :cost
      t.string :boolean
      t.string :cost_description
      t.string :string
      t.string :access
      t.string :integer
      t.string :url

      t.timestamps null: false
    end
  end
end
