class CreateUserTotalCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :user_total_coins do |t|
      t.decimal :value
      t.boolean :return_coins, :default => false

      t.timestamps
    end
  end
end
