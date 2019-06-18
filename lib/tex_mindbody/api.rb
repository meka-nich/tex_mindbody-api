require 'httparty'
require 'logger'
require 'to_bool'
require 'set'
require 'pry'
require 'active_support/core_ext/string'
require 'tex_mindbody/api/version'
require 'tex_mindbody/api/configuration'
require 'tex_mindbody/api/model'
require 'tex_mindbody/api/endpoint'

module TexMindbody
  module Api
    class << self
      attr_reader :headers
      attr_accessor :logger

      def configure
        yield config
        init
      end

      def config
        @config ||= TexMindbody::Api::Configuration.new
      end

      def init
        logger ||= Logger.new STDOUT
        logger.level = Logger::WARN

        if TexMindbody::Api.config.rest_api.nil? || TexMindbody::Api.config.rest_api.empty?
          TexMindbody::Api.config.rest_api = "https://api.mindbodyonline.com/public/v6"
        end

        if TexMindbody::Api.config.username.nil? || TexMindbody::Api.config.password.nil?
          Raise ArgumentError, "config.username & config.password must be set"
        end

        # Get the auth_token
        if TexMindbody::Api.config.auth_token.nil?
          TexMindbody::Api.issue
        end
        update_headers
      end

      def update_headers
        @headers = {
          "Api-Key": TexMindbody::Api.config.api_key,
          "SiteId": TexMindbody::Api.config.site_id,
          "Authorization": TexMindbody::Api.config.auth_token
        }
      end

      def validate_query q, query_opts
        raise ArgumentError.new "Invalid query parameters used #{q.keys.to_s}" unless q.keys.to_set.subset?(query_opts.to_set)
      end

      def paginated_get path, response_item, q = {}
        results = []
        offset = 0
        query_params = q.map { |k,v| "#{k}=#{v}"}.join('&')
        query_params += '&' unless query_params.empty?
        loop do
          path_paginated = "#{path}?#{query_params}offset=#{offset}&limit=200"
          response = HTTParty.get path_paginated, headers: @headers
          raise IOError.new response if response.server_error?
          raise ArgumentError.new response unless response.success?
          results += response[response_item]
          break if ( (response['PaginationResponse']['PageSize'] + response['PaginationResponse']['RequestedOffset'] ) == response['PaginationResponse']['TotalResults'] )
          offset += 200
        end
        results
      end
    end
  end
end