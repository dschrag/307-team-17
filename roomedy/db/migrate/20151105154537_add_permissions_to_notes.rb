class AddPermissionsToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :permissions, index: true
    add_foreign_key :notes, :permissions
  end
end
