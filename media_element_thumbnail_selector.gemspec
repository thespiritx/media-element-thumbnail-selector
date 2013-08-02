$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "media_element_thumbnail_selector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "media-element-thumbnail-selector"
  s.version     = MediaElementThumbnailSelector::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MediaElementThumbnailSelector."
  s.description = "TODO: Description of MediaElementThumbnailSelector."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3"

end
