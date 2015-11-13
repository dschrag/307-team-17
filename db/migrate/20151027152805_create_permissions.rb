class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user
      t.integer :level
      t.references :permissable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
