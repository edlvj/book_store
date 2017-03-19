source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'inherited_resources'
gem 'devise', '4.2.0'
gem 'haml-rails', '~> 0.9'
gem 'aasm', '4.11.1'
gem 'wicked', '1.3.0'
gem 'carrierwave', '~> 1.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'rectify'
gem 'drape'
gem 'ffaker'
gem 'cancan'
gem 'kaminari'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 4.2.1'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'


group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
end

group :test do
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
