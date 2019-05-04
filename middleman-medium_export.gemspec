# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-medium_export"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TheSmartnik"]
  s.email       = ["misharinn@@gmail.com"]
  # s.homepage    = "http://example.com"
  s.summary     = %q{An extension that allows to export your articles to medium}
  # s.description = %q{A longer description of your extension}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])
  s.add_runtime_dependency("middleman-blog")
  s.add_runtime_dependency("nokogiri")
  s.add_runtime_dependency("httparty", ["~> 0.16.3"])

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
  s.add_development_dependency("pry")
  s.add_development_dependency("middleman-cli")
end
