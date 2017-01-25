class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.boolean :return_coins, :default => false
      t.boolean :purchased, :default => false
      t.timestamps
    end
  end
end
