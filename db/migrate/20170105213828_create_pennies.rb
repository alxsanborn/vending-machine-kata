class CreatePennies < ActiveRecord::Migration[5.0]
  def change
    create_table :pennies do |t|

      t.timestamps
    end
  end
end
