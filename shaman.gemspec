# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shaman/version'

Gem::Specification.new do |spec|
  spec.name          = "shaman"
  spec.version       = Shaman::VERSION
  spec.authors       = ["Micah Cooper"]
  spec.email         = ["micah@mrmicahcooper.com"]
  spec.summary       = %q{Mack a Sha man.}
  spec.description   = %q{Convert a string into a MD5. If the string is Valid JSON, parse it, sort the keys, and then turn it into a MD5.}
  spec.homepage      = "http://github.com/mrmicahcooper/shaman"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oj"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
