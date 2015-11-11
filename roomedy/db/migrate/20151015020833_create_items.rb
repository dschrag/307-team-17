class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :item_price, :precision => 8, :scale => 2
      t.integer :item_amount
      t.string  :item_name
      t.boolean :visibility
      t.integer :frequency
    
      t.references :user, index: true
      t.references :house, index: true
      t.timestamps null: false
    end
  end
end