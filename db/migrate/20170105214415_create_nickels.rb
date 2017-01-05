class CreateNickels < ActiveRecord::Migration[5.0]
  def change
    create_table :nickels do |t|

      t.timestamps
    end
  end
end
