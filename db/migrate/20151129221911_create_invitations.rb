class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :token, index: true
      t.references :user
      t.references :house

      t.timestamps null: false
    end
  end
end
