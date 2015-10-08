class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :message
      t.integer :createdByUser
      t.integer :usersCanSee, array: true

      t.timestamps null: false
    end
  end
end
