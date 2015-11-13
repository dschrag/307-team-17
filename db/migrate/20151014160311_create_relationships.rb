class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
    	t.references :house, index: true
    	t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :joined_tables, :houses
    add_foreign_key :joined_tables, :users
  end
end
