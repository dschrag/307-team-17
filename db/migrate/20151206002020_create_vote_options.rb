class CreateVoteOptions < ActiveRecord::Migration
  def change
    create_table :vote_options do |t|
      t.string :title
      t.references :poll, index: true

      t.timestamps null: false
    end
    add_foreign_key :vote_options, :polls
  end
end
