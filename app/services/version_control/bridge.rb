module VersionControl
  class Bridge
    attr_reader :api

    def initialize(api)
      @api = api
    end

    def repositories(org:)
      api.repositories(org:)
    end

    def commits(owner:, repo:, per_page:)
      api.commits(owner:, repo:, per_page:)
    end

    def workflow_runs(owner:, repo:, per_page:)
      api.workflow_runs(owner:, repo:, per_page:)
    end

    def branches(owner:, repo:)
      api.branches(owner:, repo:)
    end

    def repository_content(owner:, repo:, path:)
      api.repository_content(owner:, repo:, path:)
    end

    def pull_requests(owner:, repo:, per_page:)
      api.pull_requests(owner:, repo:, per_page:)
    end
  end
end