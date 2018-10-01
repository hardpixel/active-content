# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_content/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_content'
  spec.version       = ActiveContent::VERSION
  spec.authors       = ['Olibia Tsati', 'Jonian Guveli']
  spec.email         = ['info@hardpixel.eu']
  spec.summary       = %q{STI ActiveRecord models for dynamic CMS models}
  spec.description   = %q{Generates base inheritable models Content, Taxonomy, Upload, Meta, Profile and Template.}
  spec.homepage      = 'https://github.com/hardpixel/active-content'
  spec.license       = 'MIT'
  spec.files         = Dir['{lib/**/*,[A-Z]*}']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 5.0'
  spec.add_dependency 'active_delegate', '~> 1.0'
  spec.add_dependency 'ancestry', '~> 3.0'
  spec.add_dependency 'enumerize', '~> 2.1'
  spec.add_dependency 'carrierwave', '~> 1.2'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
