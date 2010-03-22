class <%= file_name.camelcase %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :<%= unique_hash_column %>, :integer
    add_index :<%= table_name %>, :<%= unique_hash_column %>
    # Generate hashes for existing records
    <%= class_name %>.all.collect { |r| r.save(false) }
  end

  def self.down
    remove_column :<%= table_name %>, :<%= unique_hash_column %>
  end
end
