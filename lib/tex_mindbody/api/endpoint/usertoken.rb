module TexMindbody
    module Api
      class << self
        def issue
          path = "#{TexMindbody::Api.config.rest_api}/usertoken/issue"
          headers = {
            "Content-Type": 'application/json',
            "Api-Key": TexMindbody::Api.config.api_key,
            "SiteId": TexMindbody::Api.config.site_id
          }
          body = {
            "Username": TexMindbody::Api.config.username,
            "Password": TexMindbody::Api.config.password
          }
          response = HTTParty.post path, :headers => headers, :query => {}, :body => body.to_json
          raise IOError.new response if response.server_error?
          raise ArgumentError.new response unless response.success?
          raise RuntimeError.new response if response['AccessToken'].nil?
          TexMindbody::Api.config.auth_token = response['AccessToken']
        end
      end
    end
  end