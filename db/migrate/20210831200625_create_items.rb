class CreateItems < ActiveRecord::Migration[4.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
