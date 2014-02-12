$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lti_codeshare_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lti_codeshare_engine"
  s.version     = LtiCodeshareEngine::VERSION
  s.authors     = ["Eric Berry"]
  s.email       = ["cavneb@gmail.com"]
  s.homepage    = "https://github.com/instructure/lti_codeshare_engine"
  s.summary     = "Embed code from jsbin, jsfiddle, plnkr and codepen into your LMS"
  s.description = "Embed code from jsbin, jsfiddle, plnkr and codepen into your LMS"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency "sass-rails", ">= 3.2"
  s.add_dependency "bootstrap-sass", "~> 3.1.0"
  s.add_dependency "ims-lti"
  s.add_dependency "fiddle_fart"
  s.add_dependency "uuid", "~> 2.3.7"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
end
