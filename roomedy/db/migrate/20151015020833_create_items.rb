class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :item_price
      t.integer :item_amount
      t.string  :item_name
      # t.boolean :visibility
    
      t.references :user, index: true
      t.references :house, index: true
      t.timestamps null: false
    end
  end
end
