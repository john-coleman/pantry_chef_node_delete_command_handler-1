source 'https://rubygems.org'

gem 'pantry_daemon_common', git: 'git@github.com:wongatech/pantry_daemon_common.git'
gem 'chef','~> 11.6.0'

group :development do
  gem 'guard-rspec'
  gem 'guard-bundler'
end

group :test, :development do
  gem 'chef-zero'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'rspec-fire'
  gem 'rspec'
  gem 'pry-debugger'
  gem 'rake'
end
