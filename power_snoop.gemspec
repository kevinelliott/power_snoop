# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'power_snoop/version'

Gem::Specification.new do |spec|
  spec.name          = "power_snoop"
  spec.version       = PowerSnoop::VERSION
  spec.authors       = ["Kevin Elliott"]
  spec.email         = ["kevin@welikeinc.com"]

  spec.summary       = %q{Snoop on power consumption from known device types.}
  spec.description   = %q{Understand how much common devices are using based on their published specifications and by querying for realtime statistics.}
  spec.homepage      = 'https://github.com/kevinelliott/power_snoop'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'nori',     '~> 2.6.0'
  spec.add_dependency 'unitwise', '>= 1.0.4', '< 2.3.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake',    '~> 12.3'
end
