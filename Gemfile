source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.1.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.4', '>= 6.4.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbo-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Active Model has_secure_password
gem 'bcrypt'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'devise'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 6.1.0'

  # 假資料
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.21'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem 'rack-mini-profiler'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'

  gem 'dockerfile-rails', '>= 1.6'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
end
