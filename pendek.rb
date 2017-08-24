$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/http_client'
require 'sinatra'
require "sinatra/config_file"
require 'slim'
require 'byebug'

config_file 'config/application.yml'

get '/' do
  client = Pendek::HttpClient.new(settings.api["base"] + "urls")
  client.get

  @message = params["message"]

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
    message = "Error: #{client.errors[0]['title']}"
  else
    message = "Success"
  end

  redirect "/?message=#{message}"
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