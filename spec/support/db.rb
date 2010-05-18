ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

def suppress_stdout
  tmp = $stdout
  $stdout = StringIO.new
  yield
  $stdout = tmp
end

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :locations do |t|
      t.string     :type
      t.string     :name
      t.float      :lat, :lng
      t.string     :alias
      t.string     :unique_hash, :length => 40
      t.timestamps
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

Spec::Runner.configure do |config|
  config.before(:all)   { suppress_stdout { setup_db } }
  config.after(:all)    { suppress_stdout { teardown_db } }
end
