class AddFacebookIdentifierTo<%= @table_name.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= @table_name %>, :facebook_identifier, :string
    add_index :<%= @table_name %> , :facebook_identifier, :unique => true
  end
end
