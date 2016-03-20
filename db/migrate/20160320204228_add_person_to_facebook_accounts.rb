class AddPersonToFacebookAccounts < ActiveRecord::Migration
  def change
    add_reference :facebook_accounts, :person, index: true, foreign_key: true
  end
end
