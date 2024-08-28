module VersionControl
  module Api
    class Github
      GITHUB_API_URL = 'https://api.github.com'.freeze

      def initialize(access_token:)
        @connection ||= ConnectionFactory.github(url: GITHUB_API_URL, access_token: access_token)
      end

      def commits(owner:, repo:, per_page:)
        @connection.get("/repos/#{owner}/#{repo}/commits?per_page=#{per_page}").body
      end

      def pull_requests(owner:, repo:, per_page:)
        @connection.get("/repos/#{owner}/#{repo}/pulls?per_page=#{per_page}").body
      end

      def workflow_runs(owner:, repo:, per_page:)
        @connection.get("/repos/#{owner}/#{repo}/actions/runs?per_page=#{per_page}").body
      end

      # FIXME: This method is not used anywhere
      def repositories(org:)
        @connection.get("/orgs/#{org}/repos").body
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