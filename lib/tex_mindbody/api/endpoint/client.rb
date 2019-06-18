module TexMindbody
  module Api
    class << self
      def clients q = {}
        query_opts = %i{ClientIds SearchText IsProspect LastModifiedDate}
        validate_query q, query_opts
        path = "#{TexMindbody::Api.config.rest_api}/client/clients"
        clients = paginated_get path, 'Clients', q
        clients.map {|c| TexMindbody::Api::Model::Client.new c}
      end
    end
  end
end