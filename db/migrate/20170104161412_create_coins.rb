class CreateCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :coins do |t|
      t.decimal :weight
      t.decimal :diameter
      t.decimal :thickness

      t.timestamps
    end
  end
end
