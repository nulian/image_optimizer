# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image_optimizer_holder/version'

Gem::Specification.new do |gem|
  gem.name          = "image_optimizer_holder"
  gem.version       = ImageOptimizerHolder::VERSION
  gem.authors       = ["Peter Arentsen"]
  gem.email         = ["peter.arentsen@holder.nl"]
  gem.description   = %q{A simple image optimizer}
  gem.summary       = %q{Simply optimize images via imagemagick or pngcrush fork from image_optimizer with carrierwave included}
  gem.homepage      = "https://github.com/nulian/image_optimizer"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "carrierwave", ["~> 0.8"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "coveralls"
  gem.add_development_dependency "mime-types", "~> 1.25.1"
end
