class RemovePasswordFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :password, :string
    add_column :accounts, :password_digest, :string
  end
end
