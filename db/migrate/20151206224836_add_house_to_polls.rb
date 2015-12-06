class AddHouseToPolls < ActiveRecord::Migration
  def change
    add_reference :polls, :house, index: true
    add_foreign_key :polls, :houses
  end
end
