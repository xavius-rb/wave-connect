module VersionControl
  module Api
    class Github
      GITHUB_API_URL = "https://api.github.com".freeze
      GITHUB_API_VERSION = "2022-11-28".freeze
      GITHUB_API_ACCEPT = "application/vnd.github+json".freeze
      HEADERS = {
        "Accept" => GITHUB_API_ACCEPT,
        "X-GitHub-Api-Version" => GITHUB_API_VERSION
      }.freeze

      def initialize(auth_token:)
        @connection ||= ConnectionFactory.build(
          url: GITHUB_API_URL,
          auth_token: auth_token,
          headers: HEADERS)
      end

      def commits(owner:, repo:, per_page:)
        response = @connection.get("/repos/#{owner}/#{repo}/commits?per_page=#{per_page}")
        Rails.logger.info("Response: #{response.body.inspect}")
        response
      end

      def pull_requests(owner:, repo:, per_page:)
        response = @connection.get("/repos/#{owner}/#{repo}/pulls?per_page=#{per_page}")
        # Rails.logger.info("Response: #{response.inspect}")
        response
      end

      def workflow_runs(owner:, repo:, per_page:)
        @connection.get("/repos/#{owner}/#{repo}/actions/runs?per_page=#{per_page}")
      end

      def branches(owner:, repo:)
        @connection.get("/repos/#{owner}/#{repo}/branches")
      end

      def repository_content(owner:, repo:, path:)
        base_url = "/repos/#{owner}/#{repo}/contents"
        base_url += "/#{path}" if path.present?
        @connection.get(base_url)
      end
    end
  end
end
