# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name        = "oauth2_providable_facebook"
  s.version     = Oauth2ProvidableFacebook::VERSION
  s.authors     = ["Pierre-Luc Simard"]
  s.email       = ["plsimard@mirego.com"]
  s.homepage    = ""
  s.summary     = %q{Facebook grant to OAuth2 authentication}
  s.description = %q{Add facebook as a grant_type to the authentication done through devise_oauth2_providable}

  s.rubyforge_project = "oauth2_providable_facebook"

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "fb_graph"
  s.add_runtime_dependency "devise_oauth2_providable"
  s.files         = `git ls-files`.split("\n")

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]


end
