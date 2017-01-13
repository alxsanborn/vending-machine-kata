class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.boolean :selected, :default => false
      t.integer :quantity, :default => 0
      
      t.timestamps
    end
  end
end
