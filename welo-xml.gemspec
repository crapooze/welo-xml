# -*- encoding: utf-8 -*-
require File.expand_path('../lib/welo-xml/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["crapooze"]
  gem.email         = ["crapooze@gmail.com"]
  gem.description   = %q{An XML exporter for Welo::Resources}
  gem.summary       = %q{Painless XML writing for you Welo::Resources}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "welo-xml"
  gem.require_paths = ["lib"]
  gem.version       = Welo::Xml::VERSION
  gem.add_dependency "nokogiri"
  gem.add_dependency "welo"
end
