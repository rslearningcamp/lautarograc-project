source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'activeadmin', '~> 2.9'
# gem 'active_model_serializers', '~> 0.10.13'
gem 'bootsnap', '~> 1.4', '>= 1.4.5'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.6'
gem 'devise', '~> 4.8'
gem 'devise_token_auth', '~> 1.2'
gem 'geokit-rails', '~> 2.3', '>= 2.3.2'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'pg', '~> 1.1', '>= 1.1.4'
gem 'puma', '~> 5.6'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 6.1.5'
gem 'sass-rails', '>= 6'
gem 'shoulda-matchers', '~> 5.1'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.19'
  gem 'pry-byebug', '~> 3.9'
  gem 'rspec-json_expectations', '~> 2.2'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'
end

group :development do
  gem 'annotate', '~> 3.1', '>= 3.1.1'
  gem 'brakeman', '~> 5.1', '>= 5.1.1'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rails_best_practices', '~> 1.21'
  gem 'reek', '~> 6.0', '>= 6.0.6'
  gem 'rubocop-rails', '~> 2.12', '>= 2.12.4', require: false
  gem 'rubocop-rootstrap', '~> 1.2'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'webdrivers'
  gem 'webmock', '~> 3.14.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
