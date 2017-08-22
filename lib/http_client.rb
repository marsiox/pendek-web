require "net/http"
require "uri"
require 'json'
require 'ostruct'

module Pendek

  class HttpClient

    attr_reader :response, :errors

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def get(headers = {})
      begin
        uri = URI.parse(@endpoint)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.path, init_header.merge(headers))
        response = http.request(request).body

      rescue Errno::ECONNREFUSED
        response = error_response
      end

      @response = parse_response(response)
    end

    def post(params, headers = {})
      begin
        uri = URI.parse(@endpoint)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.path, init_header.merge(headers))
        request.body = params.to_json
        response = http.request(request).body

      rescue Errno::ECONNREFUSED
        response = error_response
      end

      @response = parse_response(response)
    end

    def error_response
      { errors: [{ title: "Connection refused" }]}.to_json
    end

    def init_header
      { "Content-Type" => "application/json" }
    end

    def parse_response(json)
      OpenStruct.new(JSON.parse(json))
    end

    def error?
      @response.respond_to?(:errors)
    end

    def errors
      @response.errors if error?
    end

  end

end