# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{is_unique}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eugene Bolshakov"]
  s.date = %q{2010-03-26}
  s.description = %q{Makes ActiveRecord return existing records instead of creating duplicates}
  s.email = %q{eugene.bolshakov@gmail.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
     "README",
     "Rakefile",
     "VERSION",
     "generators/is_unique/is_unique_generator.rb",
     "generators/is_unique/templates/is_unique_migration.rb",
     "init.rb",
     "is_unique.gemspec",
     "lib/is_unique.rb",
     "spec/spec_helper.rb",
     "spec/support/db.rb",
     "spec/unique_model_spec.rb"
  ]
  s.homepage = %q{http://github.com/loco2/is_unique}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{ActiveRecord extension to prevent duplicate records}
  s.test_files = [
    "spec/unique_model_spec.rb",
     "spec/support/db.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["= 2.3.5"])
    else
      s.add_dependency(%q<activerecord>, ["= 2.3.5"])
    end
  else
    s.add_dependency(%q<activerecord>, ["= 2.3.5"])
  end
end

