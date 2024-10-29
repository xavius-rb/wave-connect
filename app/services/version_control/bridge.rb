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
      handle_response { api.commits(owner:, repo:, per_page:) }
    end

    def workflow_runs(owner:, repo:, per_page:)
      handle_response { api.workflow_runs(owner:, repo:, per_page:) }
    end

    def branches(owner:, repo:)
      handle_response { api.branches(owner:, repo:) }
    end

    def repository_content(owner:, repo:, path:)
      handle_response { api.repository_content(owner:, repo:, path:) }
    end

    def pull_requests(owner:, repo:, per_page:)
      handle_response { api.pull_requests(owner:, repo:, per_page:) }
    end

    private

    def handle_response(&block)
      response = block.call
      if response.success?
        response.body
      else
        Rails.logger.error("Failed to fetch data from version control API: #{response.status} - #{response.reason_phrase}")
        {}
      end
    end
  end
end
