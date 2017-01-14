class CreateQuarters < ActiveRecord::Migration[5.0]
  def change
    create_table :quarters do |t|
      t.belongs_to :inserted_coin, foreign_key: true, optional: true
      t.belongs_to :coin_return, foreign_key: true, optional: true
      t.timestamps
    end
  end
end
