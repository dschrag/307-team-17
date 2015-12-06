class AddPollsToHouse < ActiveRecord::Migration
  def change
    add_reference :houses, :polls, index: true
    add_foreign_key :houses, :polls
  end
end
