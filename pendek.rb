$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/http_client'
require 'sinatra'
require "sinatra/config_file"
require 'slim'

config_file 'config/application.yml'

get '/' do
  @urls = Pendek::HttpClient.new(settings.api["base"] + "urls").get
  @message = params['message']
  slim :index
end

post '/' do
  post_params = { data: { full: params["url"] } }
  response = Pendek::HttpClient.new(settings.api["base"] + "urls").post(post_params)

  if response.errors
    message = "Error: #{response.errors[0]['title']}"
  else
    message = "Success"
  end

  redirect "/?message=#{message}"
end

get '/:short' do
  @stats = Pendek::HttpClient.new(settings.api["base"] + "urls/#{params[:short]}").get
  slim :stats
end