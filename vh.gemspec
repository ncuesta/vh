# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vh/version'

Gem::Specification.new do |gem|
  gem.name          = "vh"
  gem.version       = Vh::VERSION
  gem.authors       = ["José Nahuel Cuesta Luengo"]
  gem.email         = ["nahuelcuestaluengo@gmail.com"]
  gem.description   = %q{CLI tool for managing Virtual Hosts on a local environment.}
  gem.summary       = %q{Virtual Hosts manager.}
  gem.homepage      = "http://ncuesta.github.com/vh"

  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
