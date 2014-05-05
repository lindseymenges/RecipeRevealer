source 'https://rubygems.org'
ruby '1.9.3'

# PostgreSQL driver
gem 'pg'

# Sinatra driver
gem 'sinatra'
gem 'sinatra-contrib'

# Use Thin for our web server
gem 'thin'

gem 'activesupport'
gem 'activerecord'

gem 'rake'
#Bcrypt for password protection
gem 'bcrypt-ruby'
#Flash for error messages
gem 'rack-flash3'

gem 'shotgun'

group :test do
  gem 'shoulda-matchers'
  gem 'rack-test'
end

group :test, :development do
  gem 'rspec'
  gem 'factory_girl'
  gem 'faker'
end