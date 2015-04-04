Gem::Specification.new do |s|
  s.name        = 'necklace'
  s.version     = '0.1.1'
  s.date        = '2010-04-28'
  s.summary     = "Clojures -> macro for ruby"
  s.description = "Implements Clojures threading macros for Ruby Enumerable methods"
  s.authors     = ["Stuart Terrett"]
  s.email       = 'shterrett@gmail.com'
  s.files       = ["lib/necklace.rb"]
  s.homepage    = 'http://github.com/shterrett/necklace'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency('rake', '~> 10.4')
  s.add_development_dependency('rspec', '~> 3.2')
  s.add_development_dependency('simplecov', '~> 0.9')
  s.add_development_dependency('pry', '~> 0.10')
end
