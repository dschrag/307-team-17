class AddInformationDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number, :string
    add_column :users, :bornon, :date
  end
end
