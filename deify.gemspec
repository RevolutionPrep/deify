Gem::Specification.new do |s|
  s.name              = 'deify'
  s.version           = '0.0.2'
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = 'Sets up god/resque/redis configuration for any app using resque-based gems at Revolution Prep.'
  s.homepage          = ''
  s.email             = 'monica@revolutionprep.com'
  s.authors           = ['Monica McArthur']

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency('rails', '>= 3.0.0')

  s.description       = <<-DESC
    Sets up god/resque/redis configuration for any app using resque-based gems at Revolution Prep.
  DESC
end
