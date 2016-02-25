class RemoveParkingIdFromAddreses < ActiveRecord::Migration
  def change
    remove_column :addresses, :parking_id, :integer
  end
end
