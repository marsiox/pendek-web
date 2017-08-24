$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/http_client'
require 'sinatra'
require "sinatra/config_file"
require 'sinatra/flash'
require 'slim'
require 'byebug'

config_file 'config/application.yml'

enable :sessions

get '/' do
  client = Pendek::HttpClient.new(settings.api["base"] + "urls")
  client.get

  @message = flash[:message]

  if client.error?
    @message = "Error: #{client.errors[0]['title']}"
  else
    @urls = client.response
    slim :index
  end
end

post '/' do
  post_params = { data: { full: params["url"] } }
  client = Pendek::HttpClient.new(settings.api["base"] + "urls")
  client.post(post_params)

  if client.error?
    flash[:message] = "Error: #{client.errors[0]['title']}"
  else
    flash[:message] = "Your short URL: #{client.response.data['attributes']['short_url']}"
  end

  redirect "/"
end

get '/stats/:short' do
  client = Pendek::HttpClient.new(settings.api["base"] + "urls/#{params[:short]}")
  client.get

  if client.error?
    @message = "Error: #{client.errors[0]['title']}"
  else
    @stats = client.response
    slim :stats
  end
end