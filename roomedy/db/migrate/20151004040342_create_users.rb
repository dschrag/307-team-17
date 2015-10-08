class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :houseID
      t.integer :noteArray, array: true

      t.timestamps null: false
    end
  end
end
