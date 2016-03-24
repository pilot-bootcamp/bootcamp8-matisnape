class AddImageToCars < ActiveRecord::Migration
  def change
    add_column :cars, :image_uid, :string
    add_index :cars, :image_uid
  end
end
