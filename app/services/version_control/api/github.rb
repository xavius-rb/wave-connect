module VersionControl
  module Api
    class Github
      def initialize(access_token)
        @connection ||= ConnectionFactory.github(access_token)
      end

      def repositories(org:)
        @connection.get("/orgs/#{org}/repos").body
      end

      def commits(owner:, repo:)
        @connection.get("/repos/#{owner}/#{repo}/commits").body
      end

      def branches(owner:, repo:)
        @connection.get("/repos/#{owner}/#{repo}/branches").body
      end

      def repository_content(owner:, repo:, path:)
        base_url = "/repos/#{owner}/#{repo}/contents"
        base_url += "/#{path}" if path.present?
        @connection.get(base_url).body
      end
    end
  end
end