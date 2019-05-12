# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-medium_export"
  s.version     = "1.0.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TheSmartnik"]
  s.licenses    = ['MIT']
  s.email       = ["misharinn@gmail.com"]
  s.homepage    = "https://github.com/TheSmartnik/middleman-medium_export"
  s.summary     = %q{A Middleman extension to export your blogposts to medium}
  s.description = <<~STR
                    An extension to export your articles created with
                    middleman-blog to medium from a command line.
                  STR

  s.files         = Dir['lib/**/*', 'MIT-LICENSE', 'README.md']
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])
  s.add_runtime_dependency("middleman-blog")
  s.add_runtime_dependency("nokogiri")
  s.add_runtime_dependency("httparty", ["~> 0.16.3"])

  s.add_development_dependency("pry")
  s.add_development_dependency("middleman-cli")
end
