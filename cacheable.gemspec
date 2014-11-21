# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cacheable/version'

Gem::Specification.new do |spec|
  spec.name          = "cacheable"
  spec.version       = Cacheable::VERSION
  spec.authors       = ["Kuldeep Aggarwal"]
  spec.email         = ["kd.engineer@yahoo.co.in"]
  spec.summary       = %q{This is an utility which caches `has_many` associations.}
  spec.description   = %q{This is an utility which caches `has_many` associations.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 4.0.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
