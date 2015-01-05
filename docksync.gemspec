# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docksync/version'

Gem::Specification.new do |spec|
  spec.name          = "docksync"
  spec.version       = Docksync::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]
  spec.description   = %q{Rsync files from your macosx machine to the docker container}
  spec.summary       = %q{Rsync files from your macosx machine to the docker container}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "hashie"
  spec.add_dependency "colorize"
  spec.add_dependency "filewatcher"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end