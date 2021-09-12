class Adduseridtoitems < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :user_id, :integer
  end
end
