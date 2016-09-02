source "https://gems.ruby-china.org"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.0.0"
# Use sqlite3 as the database for Active Record

# Use Puma as the app server
gem "puma", "~> 3.0"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "bootstrap-sass"

gem "simple_form"

gem "devise"

gem "font-awesome-rails"

gem "carrierwave"
gem "mini_magick"
gem "rmagick"
gem "fog"
gem "carrierwave-aws"
gem "figaro"
gem "awesome_rails_console"
gem "annotate"
gem "ransack"
gem "will_paginate"
gem "gravatarify"
gem "acts-as-taggable-on", "~> 4.0"
gem "to_words"
gem "semantic-ui-sass", github: "doabit/semantic-ui-sass"
gem "trix"
gem "twilio-ruby", "~> 4.11.1"
gem "phonelib"
gem "active_link_to"
# simditor文本编辑器
gem "simditor"
gem "aasm"
# 分页套用bootstrap
gem 'will_paginate-bootstrap'

group :production do
  gem "pg"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platform: :mri
  gem "pry"
  gem "pry-nav"
  gem "sqlite3"
  gem "activerecord-session_store" # 我不确定这个gem要不要放在这里
  gem "rubocop"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console"
  gem "listen", "~> 3.0.5"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rails-erd"
  gem "letter_opener"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
