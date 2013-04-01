Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-sponsorships'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Sponsorships engine for Refinery CMS'
  s.date              = '2011-05-21'
  s.summary           = 'Sponsorships engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']
  s.add_dependency    'refinerycms-core',     '~> 2.0.1'
  s.add_dependency    'refinerycms-settings', '~> 2.0.0'
end
