class AddLastEditedByToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :lastEditedBy, :integer
  end
end
