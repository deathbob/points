require File.expand_path("../lib/points/version", __FILE__)
# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "points"
  s.summary = "A rails engine for building rewards systems."
  s.description = "A rails engine for building rewards systems."
  s.platform    = Gem::Platform::RUBY
  s.version = Points::VERSION
  s.authors = ['larrick@gmail.com']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

end