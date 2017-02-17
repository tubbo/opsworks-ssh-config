# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opsworks/ssh/config/version'

Gem::Specification.new do |spec|
  spec.name          = "opsworks-ssh-config"
  spec.version       = Opsworks::Ssh::Config::VERSION
  spec.authors       = ["Tom Scott"]
  spec.email         = ["tscott@weblinc.com"]

  spec.summary       = 'Generate an SSH config for your OpsWorks account'
  spec.description   = spec.description
  spec.homepage      = 'http://github.com/tubbo/opsworks-ssh-config'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'aws-sdk'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
