# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife/helper/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-helper"
  spec.version       = Knife::Helper::VERSION
  spec.authors       = ["Masashi Terui"]
  spec.email         = ["marcy9114@gmail.com"]
  spec.summary       = %q{Helper and Command builder for knife}
  spec.description   = %q{Helper and Command builder for knife (chef-server, knife-zero, etc)}
  spec.homepage      = "https://github.com/marcy-terui/knife-helper"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "chef"
  spec.add_dependency "safe_yaml"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
