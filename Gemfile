source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


gem 'rails',      '6.0.3'
gem 'puma',       '4.3.4'
gem 'sass-rails', '5.1.0'
gem 'webpacker',  '4.0.7'
gem 'turbolinks', '5.2.0'
gem 'jbuilder',   '2.9.1'
gem 'bootsnap',   '1.4.5', require: false
#gem 'bootstrap', '~> 4.1.1'
gem 'jquery-rails'
gem 'bcrypt',         '3.1.13'
gem 'rails-i18n'
gem 'active_storage_validations', '0.8.2'
gem 'carrierwave', '~> 2.0'
gem 'image_processing',           '1.9.3'
gem 'mini_magick',                '4.9.5'

gem 'faker','2.11'
gem 'will_paginate', '3.3.0'
gem 'will_paginate-bootstrap4'
gem 'fog-aws'
gem 'dotenv-rails'
gem 'recaptcha', require: "recaptcha/rails"

group :production do
  gem 'pg', '1.1.4'
end

group :development, :test do
  gem 'sqlite3', '1.4.1'
  gem 'byebug',  '11.0.1', platforms: [:mri, :mingw, :x64_mingw]

end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'capybara',           '3.28.0'
  gem 'selenium-webdriver', '3.142.4'
  gem 'webdrivers',         '4.1.2'
  gem "rspec-rails"
  gem "factory_bot_rails"
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]