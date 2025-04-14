module VersionControl
  # Proxy class for interacting with version control APIs.
  #
  # This class provides a caching layer for API responses, ensuring that
  # repeated requests for the same data are served from cache rather than
  # hitting the API repeatedly.
  #
  # @note The cache expiration time is set to 5 minutes.
  #
  # @example
  #   proxy = VersionControl::Proxy.new(api)
  #   commits = proxy.commits(owner: 'octocat', repo: 'Hello-World', per_page: 10)
  class Proxy
    CACHE_TIME = 5.minutes.freeze

    attr_reader :api

    def initialize(api)
      @api = api
    end

    def commits(owner:, repo:, per_page:)
      Rails.cache.fetch [ "commits", owner, repo ], expires_in: CACHE_TIME do
        handle_response { api.commits(owner:, repo:, per_page:) }
      end
    end

    def pull_requests(owner:, repo:, per_page:)
      Rails.cache.fetch [ "pull_requests", owner, repo ], expires_in: CACHE_TIME do
        handle_response { api.pull_requests(owner:, repo:, per_page:) }
      end
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
