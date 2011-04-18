# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "magic_multi_connections/version"

Gem::Specification.new do |s|
  s.name        = "magic_multi_connections"
  s.version     = MagicMultiConnection::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dr Nic Williams"]
  s.email       = ["drnicwilliams@gmail.com"]
  s.homepage    = "http://github.com/drnic/magic_multi_connections"
  s.summary     = %q{Your ActiveRecord classes can be accessed within multiple modules, each which targets a different DB connection.}
  s.description = %q{Your ActiveRecord classes can be accessed within multiple modules, each which targets a different DB connection. Famously tried to solve Twitter's scaling issues.}

  s.rubyforge_project = "magic_multi_connections"

  s.files         = `git ls-files`.split("\n")

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("activerecord")
  s.add_development_dependency("rake", ["~> 0.8.7"])
  s.add_development_dependency("pg")
end
