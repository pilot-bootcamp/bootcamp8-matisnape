class AddPriceToPlaceRents < ActiveRecord::Migration
  def change
    add_column :place_rents, :price, :decimal
  end
end
