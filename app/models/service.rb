class Service < ApplicationRecord
  validates :name, presence: true

  before_create do
    self.uuid = SecureRandom.uuid
  end

  has_many :environments, class_name: 'StageEnvironment', dependent: :destroy

  # given repository_url, connect to github and fetch the repository content
  def fetch_repository_content
    return [] unless version_control_bridge

    owner, repo, path = parse_repository_url
    version_control_bridge.repository_content(owner: owner, repo: repo, path: path)
  end

  def fetch_repository_branches
    return [] unless version_control_bridge

    owner, repo, _ = parse_repository_url
    version_control_bridge.branches(owner: owner, repo: repo)
  end

  def fetch_pull_requests
    return [] unless version_control_bridge

    owner, repo, _ = parse_repository_url
    version_control_bridge.pull_requests(owner: owner, repo: repo, per_page: 2)
  end

  def fetch_commits
    return [] unless version_control_bridge

    owner, repo, _ = parse_repository_url
    version_control_bridge.commits(owner: owner, repo: repo, per_page: 2)
  end

  def fetch_workflow_runs
    return [] unless version_control_bridge

    owner, repo, _ = parse_repository_url
    version_control_bridge.workflow_runs(owner: owner, repo: repo, per_page: 2)
  end

  def parse_repository_url
    repository_url.match(%r{github.com/([^/]+)/([^/]+)/?(.*)$})&.captures
  end


  private

  def version_control_bridge
    @version_control ||= VersionControl::Bridge.new(version_control_api)
  end

  def version_control_api
    # TODO: determine the api based on the service
    VersionControl::Api::Github.new(access_token: repository_access_token)
  end
end
