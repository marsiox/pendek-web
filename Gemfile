source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'sinatra', '~> 1.4', '>= 1.4.7'
gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
gem 'slim'
gem 'json'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end
