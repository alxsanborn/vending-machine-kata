class CreateInsertedCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :inserted_coins do |t|
      t.decimal :value
      t.belongs_to :order, foreign_key: true, optional: true
      t.timestamps
    end
  end
end
