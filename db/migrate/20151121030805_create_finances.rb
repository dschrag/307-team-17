class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.references :user, index: true
      t.monetize :net_balance
      t.monetize :net_income
      t.monetize :net_expenses
      t.monetize :expenses_last_month
      t.monetize :income_last_month

      t.timestamps null: false
    end

    add_foreign_key :finances, :users
    add_foreign_key :users, :finances
  end
end
