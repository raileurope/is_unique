begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "is_unique"
    gemspec.summary = "ActiveRecord extension to prevent duplicate records"
    gemspec.description = "Makes ActiveRecord return existing records instead of creating duplicates"
    gemspec.email = "eugene.bolshakov@gmail.com"
    gemspec.homepage = "http://github.com/loco2/is_unique"
    gemspec.authors = ["Eugene Bolshakov"]
    gemspec.add_dependency 'activerecord', '~>2.3'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
