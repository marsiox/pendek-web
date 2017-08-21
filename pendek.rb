require 'sinatra'
require "sinatra/config_file"
require 'slim'
require "net/http"
require "uri"
require 'json'
require 'ostruct'

config_file 'config/application.yml'

get '/' do
  uri = URI.parse(settings.api["base"] + "/urls")
  response = Net::HTTP.get_response(uri)
  @urls = OpenStruct.new(JSON.parse(response.body))

  slim :index
end

post '/' do
  uri = URI.parse(settings.api["base"] + "/urls")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, initheader = {"Content-Type" => "application/json"})
  request.body = { data: { full: params["url"] } }.to_json
  response = http.request(request)
  redirect "/"
end

get '/:short' do
  uri = URI.parse(settings.api["base"] + "urls/#{params[:short]}")
  response = Net::HTTP.get_response(uri)
  @stats = OpenStruct.new(JSON.parse(response.body))

  slim :stats
end