source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.1.2"

gem "bcrypt"
gem "bootsnap", ">= 1.4.4", require: false
gem "bootstrap", "~>4.6"
gem "capybara", ">= 3.26"
gem "cocoon"
gem "config"
gem "faker"
gem "jbuilder", "~> 2.7"
gem "jquery-rails", "~> 4.4"
gem "mysql2"
gem "net-smtp", require: false
gem "pagy"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6"
gem "rails-controller-testing"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"

group :development, :test do
  gem "factory_bot_rails"
  gem "pry"
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
  gem "shoulda-matchers"
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "database_cleaner-active_record"
  gem "rails-controller-testing"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "simplecov"
  gem "simplecov-rcov"
  gem "shoulda-matchers"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
