class <%= file_name.camelcase %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :<%= unique_hash_column %>, :string, :limit => 40
    add_index :<%= table_name %>, :<%= unique_hash_column %>
    # Generate hashes for existing records
    <%= class_name %>.find_each { |r| r.save(false) }
  end

  def self.down
    remove_column :<%= table_name %>, :<%= unique_hash_column %>
  end
end
