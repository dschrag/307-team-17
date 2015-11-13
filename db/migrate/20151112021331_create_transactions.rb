class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, index: true
      t.string :buyer
      t.string :seller
      t.monetize :price
      t.boolean :recurring
      t.text :reason
      t.date :date_due
      t.date :date_paid

      t.timestamps null: false
    end
    add_foreign_key :transactions, :users
  end
end
