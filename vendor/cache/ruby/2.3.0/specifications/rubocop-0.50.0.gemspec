# -*- encoding: utf-8 -*-
# stub: rubocop 0.50.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rubocop"
  s.version = "0.50.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/bbatsov/rubocop/issues", "changelog_uri" => "https://github.com/bbatsov/rubocop/blob/master/CHANGELOG.md", "documentation_uri" => "https://rubocop.readthedocs.io/", "homepage_uri" => "https://rubocop.readthedocs.io/", "source_code_uri" => "https://github.com/bbatsov/rubocop/" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["Bozhidar Batsov", "Jonas Arvidsson", "Yuji Nakayama"]
  s.date = "2017-09-14"
  s.description = "    Automatic Ruby code style checking tool.\n    Aims to enforce the community-driven Ruby Style Guide.\n"
  s.email = "rubocop@googlegroups.com"
  s.executables = ["rubocop"]
  s.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  s.files = ["LICENSE.txt", "README.md", "bin/rubocop"]
  s.homepage = "https://github.com/bbatsov/rubocop"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Automatic Ruby code style checking tool."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rainbow>, ["< 3.0", ">= 2.2.2"])
      s.add_runtime_dependency(%q<parser>, ["< 3.0", ">= 2.3.3.1"])
      s.add_runtime_dependency(%q<powerpack>, ["~> 0.1"])
      s.add_runtime_dependency(%q<ruby-progressbar>, ["~> 1.7"])
      s.add_runtime_dependency(%q<unicode-display_width>, [">= 1.0.1", "~> 1.0"])
      s.add_runtime_dependency(%q<parallel>, ["~> 1.10"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
    else
      s.add_dependency(%q<rainbow>, ["< 3.0", ">= 2.2.2"])
      s.add_dependency(%q<parser>, ["< 3.0", ">= 2.3.3.1"])
      s.add_dependency(%q<powerpack>, ["~> 0.1"])
      s.add_dependency(%q<ruby-progressbar>, ["~> 1.7"])
      s.add_dependency(%q<unicode-display_width>, [">= 1.0.1", "~> 1.0"])
      s.add_dependency(%q<parallel>, ["~> 1.10"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<rainbow>, ["< 3.0", ">= 2.2.2"])
    s.add_dependency(%q<parser>, ["< 3.0", ">= 2.3.3.1"])
    s.add_dependency(%q<powerpack>, ["~> 0.1"])
    s.add_dependency(%q<ruby-progressbar>, ["~> 1.7"])
    s.add_dependency(%q<unicode-display_width>, [">= 1.0.1", "~> 1.0"])
    s.add_dependency(%q<parallel>, ["~> 1.10"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
  end
end
