class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.string :uid

      t.timestamps null: false
    end
    add_index :facebook_accounts, :uid
  end
end
