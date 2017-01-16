class CreateInsertedCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :inserted_coins do |t|
      t.decimal :value
      t.belongs_to :order, foreign_key: true, optional: true
      t.integer :quarters, :default => 0
      t.integer :dimes, :default => 0
      t.integer :nickels, :default => 0
      t.timestamps
    end
  end
end
