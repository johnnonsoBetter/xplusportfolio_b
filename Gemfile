source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.0.4', '>= 6.0.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
gem 'friendly_id', '~> 5.4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
 gem 'jbuilder', '~> 2.7'
 gem 'devise_token_auth'

 gem 'devise'
#Use Redis adapter to run Action Cable in production
gem 'redis'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'webpush'

gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'acts_as_votable'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'cloudinary'



# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem "figaro"
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'pagy', '~> 5.6' 
gem 'searchkick', '~> 4.6', '>= 4.6.3'

gem 'omniauth-github'

 
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'simplecov', require: false, group: :test
  gem 'shoulda-matchers'
  gem 'kaminari'
  gem 'dox', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "noticed", "~> 1.5"

gem 'sidekiq'

gem 'public_activity'

