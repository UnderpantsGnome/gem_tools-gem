Gem::Specification.new do |s|
  s.name = %q{gem_tools}
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Moen"]
  s.date = %q{2009-01-24}
  s.default_executable = %q{gemtools}
  s.description = %q{A lightweight tool to manage gems using a config file, similar to GemInstaller}
  s.email = ["michael@underpantsgnome.com"]
  s.executables = ["gemtools"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "PostInstall.txt", "README.txt"]
  s.files = ["History.txt", "License.txt", "PostInstall.txt", "README.txt", "lib/gem_tools.rb", "lib/gem_tools/version.rb", "bin/gemtools", "config/gems.template.yml"]
  s.has_rdoc = true
  s.homepage = %q{http://underpantsgnome.rubyforge.org}
  s.post_install_message = %q{
For more information on GemTools see http://github.com/UnderpantsGnome/gem_tools/wikis
}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{underpantsgnome}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A lightweight tool to manage gems using a config file, similar to GemInstaller}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end

