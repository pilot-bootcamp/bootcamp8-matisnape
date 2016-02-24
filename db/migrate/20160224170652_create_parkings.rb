class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.integer :places
      t.string :kind
      t.decimal :hour_price
      t.decimal :day_price
      t.integer :address_id
      t.integer :owner_id
    end
    add_index :parkings, :address_id
    add_index :parkings, :owner_id
  end
end
