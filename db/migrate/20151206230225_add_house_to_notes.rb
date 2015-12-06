class AddHouseToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :house, index: true
    add_foreign_key :notes, :houses
  end
end
