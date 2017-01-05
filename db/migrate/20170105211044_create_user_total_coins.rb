class CreateUserTotalCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :user_total_coins do |t|
      t.decimal :value

      t.timestamps
    end
  end
end
