class <%= file_name.camelcase %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :<%= unique_hash_column %>, :integer
    add_index :<%= table_name %>, :<%= unique_hash_column %>
  end

  def self.down
    remove_column :<%= table_name %>, :<%= unique_hash_column %>
  end
end
