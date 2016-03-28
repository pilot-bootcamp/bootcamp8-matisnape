class AddImageNameToCars < ActiveRecord::Migration
  def change
    add_column :cars, :image_name, :string
  end
end
