source 'https://rubygems.org'

gem 'rails',        '3.2.13'
gem 'rails-api',    '~> 0.1.0'
gem 'pg',           '~> 0.15.1'

group :development, :test do
  gem 'sqlite3',        '~> 1.3.7'
  gem 'rspec-rails',    '~> 2.0'
  gem 'dotenv-rails',   '~> 0.7.0'
end

group :test do
  gem 'database_cleaner',   '~> 1.0.1'
end

group :development do
  gem 'guard-rspec',        '~> 3.0.1'
end

gem 'sorcery',          '~> 0.8.1'
gem 'resque',           '~> 1.24.1' ,   require: 'resque/server'
gem 'rack-cors', require: 'rack/cors', git: 'git://github.com/cyu/rack-cors'
