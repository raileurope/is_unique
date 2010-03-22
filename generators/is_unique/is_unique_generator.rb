class IsUniqueGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.migration_template 'is_unique_migration.rb', 'db/migrate', 
        :assigns => {:unique_hash_column => actions.first || 'unique_hash' }
    end
  end

  def banner
    "Usage: #{$0} #{spec.name} ModelName [custom_unique_has_column_name] [options]"
  end

  def file_name
    "add_unique_hash_column_to_#{@plural_name}"
  end
end
