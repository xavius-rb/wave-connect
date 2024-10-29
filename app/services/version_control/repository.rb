module VersionControl
  class Repository
    attr_reader :access_token, :url, :owner, :repo, :path

    def initialize(service)
      # defines service interface
      @url = service.repository_url
      @access_token = service.repository_access_token

      @owner, @repo, @path = parse_repository_url
    end

    def fetch_content
      api_bridge.repository_content(owner: owner, repo: repo, path: path)
    end

    def fetch_branches
      api_bridge.branches(owner: owner, repo: repo)
    end

    def fetch_pull_requests
      api_bridge.pull_requests(owner: owner, repo: repo, per_page: 2)
    end

    def fetch_commits
      api_bridge.commits(owner: owner, repo: repo, per_page: 2)
    end

    def fetch_workflow_runs
      api_bridge.workflow_runs(owner: owner, repo: repo, per_page: 2)
    end

    private

    def version_control_api
      # TODO: determine the api based on the service
      VersionControl::Api::Github.new(access_token: @access_token)
    end

    def parse_repository_url
      url.match(%r{github.com/([^/]+)/([^/]+)/?(.*)$})&.captures
    end

    def api_bridge
      @api_bridge ||= VersionControl::Bridge.new(version_control_api)
    end
  end
end
