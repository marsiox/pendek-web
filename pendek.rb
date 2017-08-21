$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/http_client'
require 'sinatra'
require "sinatra/config_file"
require 'slim'

config_file 'config/application.yml'

get '/' do
  response = Pendek::HttpClient.new(settings.api["base"] + "urls").get
  @message = params['message']

  if response.errors
    @message = "Error: #{response.errors[0]['title']}"
  else
    @urls = response
    slim :index
  end
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
  response = Pendek::HttpClient.new(settings.api["base"] + "urls/#{params[:short]}").get

  if response.errors
    @message = "Error: #{response.errors[0]['title']}"
  else
    @stats = response
    slim :stats
  end
end