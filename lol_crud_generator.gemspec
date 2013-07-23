$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lol_crud_generator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lol_crud_generator"
  s.version     = LolCrudGenerator::VERSION
  s.authors     = ["Eduardo Zaghi"]
  s.email       = ["eduardo@loldesign.com.br"]
  s.homepage    = "http://wwww.loldesign.com.br"
  s.summary     = "Create a crud"
  s.description = "Create crud index/show/new/edit/create/update/destoy"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
end
