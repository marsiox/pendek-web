# README
Example client app, running Sinatra, consuming [pendek-api](https://github.com/marsiox/pendek-api). Business logic is located in the main controller `pendek.rb`.
Folder `./lib` contains a wrapper for Net::HTTP. Views are using Slim templates.

## Requirements
* Ruby v. 2.4.1

## Installation
`bundle`

## Configuration
Edit `config/application.yml` to set up the pendek-api base URL.

## Starting app
Run `ruby pendek.rb`. Sinatra by default is running on port `4567`.

Go to `http://localhost:4567/` in your browser.
