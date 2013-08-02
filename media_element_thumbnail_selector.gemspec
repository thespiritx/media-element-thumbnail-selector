$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "media_element_thumbnail_selector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "media-element-thumbnail-selector"
  s.version     = MediaElementThumbnailSelector::VERSION
  s.authors     = ["Adam Hallett"]
  s.email       = ["adam.t.hallett@gmail.com"]
  s.homepage    = "http://github.com/atomical/media-element-thumbnail-selector"
  s.summary     = "Create thumbnails directly from the player"
  s.description = "Create thumbnails directly from the player"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_development_dependency 'guard-coffeescript'
end
