class AddFacebookIdentifierToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_identifier, :string
    add_index :users , :facebook_identifier, :unique => true
  end
end
