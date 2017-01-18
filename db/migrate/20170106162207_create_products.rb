class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 3
      t.integer :quantity, :default => 0
      t.boolean :selected, :default => false
      t.attachment :product_image
      t.timestamps
    end
  end
end
