class CreateQuarters < ActiveRecord::Migration[5.0]
  def change
    create_table :quarters do |t|
      t.belongs_to :user_total_coin, foreign_key: true, optional: true

      t.timestamps
    end
  end
end