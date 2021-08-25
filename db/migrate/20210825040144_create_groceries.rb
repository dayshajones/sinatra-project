class CreateGroceries < ActiveRecord::Migration[4.2]
  def change
    create_table :groceries do |t|
      t.string :name
      t.integer :quatity
      t.timestamps null: false
    end
  end
end
