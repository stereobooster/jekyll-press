# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jekyll-press/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors     = ["sterebooster"]
  gem.email       = ["stereobooster@gmail.com"]
  gem.description = %q{Minifier plugin for jekyll. Minifies all html, js, css files. Simple just drop it in solution. No Java required}
  gem.summary     = %q{Minifier plugin for jekyll. This plugin compress html with the help of html_press, compress JavaScript files with the help of uglifier, compress css files with the help of css_press}
  gem.homepage    = "http://github.com/stereobooster/jekyll-press"
  gem.license     = "MIT"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jekyll-press"
  gem.require_paths = ["lib"]
  gem.version       = Jekyll::Press::VERSION

  gem.add_dependency "jekyll"
  gem.add_dependency "html_press", ">= 0.8.2"
  gem.add_dependency "multi_css", ">= 0.1.0"
  gem.add_dependency "multi_js", ">= 0.1.0"

  gem.add_development_dependency "rake"
end
