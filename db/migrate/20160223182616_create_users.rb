class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :
      t.string :email
      t.string :
      t.string :zip_code
      t.integer :
      t.string :password_digest
      t.string :string

      t.timestamps null: false
    end
  end
end
