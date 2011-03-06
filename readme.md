# Strangeloop Conference Site

To get started, you'll need rvm and bundler

`$> gem install rvm --no-rdoc --no-ri`

`$> rvm install ree`

The cd out of the top directory, and back in (this should trigger RVM to
notice the .rvmrc file).  Then:

`$> gem install bundler --no-rdoc --no-ri`

`$> bundle install`

`$> rake db:migrate`

`$> rake db:seed`

This should complete the setup.
