module VersionControl
  class Repository
    attr_reader :api_proxy, :owner, :repo, :path

    def initialize(service)
      @api_proxy = VersionControl::Proxy.new(service.version_control_api)
      @owner, @repo, @path = service.repository_url.match(%r{github.com/([^/]+)/([^/]+)/?(.*)$})&.captures
    end

    def fetch_pull_requests
      api_proxy.pull_requests(owner: owner, repo: repo, per_page: 3)
    end

    def fetch_commits
      api_proxy.commits(owner: owner, repo: repo, per_page: 3)
    end

    def fetch_branches
      api_proxy.branches(owner: owner, repo: repo)
    end

    def fetch_workflow_runs
      api_proxy.workflow_runs(owner: owner, repo: repo, per_page: 2)
    end
  end
end
