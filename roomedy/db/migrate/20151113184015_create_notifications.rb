class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.string :type

      t.boolean :web
      t.boolean :mobile
      t.boolean :email

      t.timestamps null: false
    end
    add_foreign_key :users, :notifications
  end
end
