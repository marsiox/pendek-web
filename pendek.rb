require 'sinatra'
require 'slim'

get '/' do
  slim :index
end

post '/' do
  slim :index
end
