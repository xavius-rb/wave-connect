module VersionControl
  class ConnectionFactory
    GITHUB_API_URL = 'https://api.github.com'.freeze

    def self.github
      Faraday.new(url: GITHUB_API_URL) do |builder|
        #builder.request :authorization, 'Bearer', -> { Rails.application.credentials.github[:access_token] }
        builder.response :json
        builder.request :url_encoded
        builder.adapter Faraday.default_adapter

        builder.headers['Accept'] = 'application/vnd.github+json'
        builder.headers['X-GitHub-Api-Version'] = '2022-11-28'
      end
    end
  end
end