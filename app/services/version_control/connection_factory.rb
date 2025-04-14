module VersionControl
  class ConnectionFactory
    def self.build(url:, auth_token:, headers: {})
      Faraday.new(url: url) do |builder|
        builder.request :authorization, :Bearer, auth_token
        builder.response :json
        builder.request :url_encoded
        builder.adapter Faraday.default_adapter
        headers.each { builder.headers[_1] = _2 }
      end
    end
  end
end
