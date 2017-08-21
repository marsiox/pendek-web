require "net/http"
require "uri"
require 'json'
require 'ostruct'

module Pendek

  class HttpClient

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def get
      begin
        uri = URI.parse(@endpoint)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.path, initheader = {"Content-Type" => "application/json"})
        OpenStruct.new(JSON.parse(http.request(request).body))
      rescue Errno::ECONNREFUSED
        OpenStruct.new(JSON.parse({ errors: [{ title: "Connection refused" }]}.to_json))
      end
    end

    def post(params)
      begin
        uri = URI.parse(@endpoint)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.path, initheader = {"Content-Type" => "application/json"})
        request.body = params.to_json
        OpenStruct.new(JSON.parse(http.request(request).body))
      rescue Errno::ECONNREFUSED
        OpenStruct.new(JSON.parse({ errors: [{ title: "Connection refused" }]}.to_json))
      end
    end

  end

end