module VersionControl
  class Bridge
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def repositories(org:)
      client.repositories(org:)
    end

    def commits(owner:, repo:)
      client.commits(owner:, repo:)
    end

    def repository_content(owner:, repo:, path:)
      client.repository_content(owner:, repo:, path:)
    end
  end
end