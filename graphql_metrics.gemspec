$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "graphql_metrics/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "graphql_metrics"
  s.version     = GraphqlMetrics::VERSION
  s.authors     = ["Emile Bosch"]
  s.email       = ["emilebosch@me.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GraphqlMetrics."
  s.description = "TODO: Description of GraphqlMetrics."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_development_dependency "sqlite3"
end
