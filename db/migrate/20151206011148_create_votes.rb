class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :vote_option, index: true

      t.timestamps null: false
    end
    add_foreign_key :votes, :users
    add_foreign_key :votes, :vote_options
    add_index :votes, [:vote_option_id, :user_id], unique: true
  end
end
