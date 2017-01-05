class CreateQuarters < ActiveRecord::Migration[5.0]
  def change
    create_table :quarters do |t|

      t.timestamps
    end
  end
end
