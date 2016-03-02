class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password
      t.integer :person_id
    end
    add_index :accounts, :person_id
  end
end
