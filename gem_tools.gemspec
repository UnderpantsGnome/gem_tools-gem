# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gem_tools}
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Moen"]
  s.date = %q{2010-02-21}
  s.default_executable = %q{gemtools}
  s.description = %q{A lightweight tool to manage gems using a config file, similar to GemInstaller}
  s.email = %q{michael@underpantsgnome.com}
  s.executables = ["gemtools"]
  s.extra_rdoc_files = [
    "README.textile",
     "README.txt"
  ]
  s.files = [
    ".gitignore",
     "History.txt",
     "License.txt",
     "README.textile",
     "README.txt",
     "Rakefile",
     "VERSION",
     "bin/gemtools",
     "config/gems.template.yml",
     "config/gems.yml",
     "gem_tools.gemspec",
     "lib/gem_tools.rb",
     "spec/gem_tools_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/UnderpantsGnome/gem_tools-gem}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A gem manager}
  s.test_files = [
    "spec/gem_tools_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

