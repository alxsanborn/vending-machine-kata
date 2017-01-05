class CreateDimes < ActiveRecord::Migration[5.0]
  def change
    create_table :dimes do |t|

      t.timestamps
    end
  end
end
