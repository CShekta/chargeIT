class AddFieldsToDeviseUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :zip_code, :string
    add_column :users, :telephone, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
