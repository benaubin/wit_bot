# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wit_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'wit_bot'
  spec.version       = WitBot::VERSION
  spec.authors       = ['Ben (@penne12_)']
  spec.email         = ['ben@bensites.com']

  spec.summary       = %q{A better wit.ai client for Ruby. Written in Ruby. With an api for creating bots.}
  spec.description   = %q{A better wit.ai client for Ruby. Written in Ruby. With an api for creating bots. It's Pretty Awesome™}
  spec.homepage      = 'http://bensites.com/wit_bot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['wit']
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "simplecov", ">= 0"

  spec.add_dependency "http", ">= 1.0.2"
  spec.add_dependency "activesupport", ">= 4"
  spec.add_dependency "require_all", ">= 1.3.3"
  spec.add_dependency "awesome_print", ">= 1.6.1"
end
