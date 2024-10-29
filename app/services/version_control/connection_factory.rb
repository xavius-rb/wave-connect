module VersionControl
  class ConnectionFactory
    def self.github(url:, access_token:)
      Faraday.new(url: url) do |builder|
        builder.request :authorization, 'Bearer', -> { access_token }
        builder.response :json
        builder.request :url_encoded
        builder.adapter Faraday.default_adapter

        builder.headers['Accept'] = 'application/vnd.github+json'
        builder.headers['X-GitHub-Api-Version'] = '2022-11-28'
      end
    end
  end
end
