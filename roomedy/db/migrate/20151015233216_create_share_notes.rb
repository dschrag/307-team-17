class CreateShareNotes < ActiveRecord::Migration
  def change
    create_table :share_notes do |t|
      t.references :note, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :joined_tables, :notes
    add_foreign_key :joined_tables, :users
  end
end
