class AddUuidToPlaceRents < ActiveRecord::Migration
  def change
    add_column :place_rents, :uuid, :string
    add_index :place_rents, :uuid, unique: true
  end
end
