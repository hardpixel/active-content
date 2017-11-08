# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cms_basics/version"

Gem::Specification.new do |spec|
  spec.name          = 'cms_basics'
  spec.version       = CmsBasics::VERSION
  spec.authors       = ['Olibia Tsati']
  spec.email         = ['olibia@hardpixel.eu']
  spec.summary       = %q{Base ActiveRecord models for a CMS}
  spec.description   = %q{Generates base models Pages, Posts, Media, Templates, Categories and Tags.}
  spec.homepage      = 'https://github.com/hardpixel/cms-basics'
  spec.license       = 'MIT'
  spec.files         = Dir['{lib/**/*,[A-Z]*}']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 5.0'
  spec.add_dependency 'active_delegate', '~> 0.1'
  spec.add_dependency 'ancestry', '~> 3.0'
  spec.add_dependency 'enumerize', '~> 2.1'
  spec.add_dependency 'carrierwave', '~> 1.2'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
