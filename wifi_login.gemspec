# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wifi_login/version'

Gem::Specification.new do |gem|
  gem.name          = "wifi_login"
  gem.version       = WifiLogin::VERSION
  gem.authors       = ["MATSUOKA Kohei"]
  gem.email         = ["kohei@machu.jp"]
  gem.description   = %q{An automatically login tool for a public wireless LAN.}
  gem.summary       = %q{An automatically login tool when connected to a public wireless LAN.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'mechanize'
  gem.add_runtime_dependency 'pit'
  gem.add_runtime_dependency 'systemu'

end
