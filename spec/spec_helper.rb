ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'
require File.expand_path '../../pendek.rb', __FILE__
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: false)

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }

