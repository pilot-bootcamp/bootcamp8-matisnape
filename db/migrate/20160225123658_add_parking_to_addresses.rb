class AddParkingToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :parking, index: true, foreign_key: true
  end
end
