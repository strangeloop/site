Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-proposals'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Proposals engine for Refinery CMS'
  s.date              = '2011-01-30'
  s.summary           = 'Proposals engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']
  s.add_dependency    'refinerycms-core',     '~> 2.0.1'
  s.add_dependency    'refinerycms-settings', '~> 2.0.0'
end
