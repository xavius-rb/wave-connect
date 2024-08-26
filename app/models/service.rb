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

  private
  def parse_repository_url
    repository_url.match(%r{github.com/([^/]+)/([^/]+)/?(.*)$})&.captures
  end

  def version_control_bridge
    return unless client
    @version_control ||= VersionControl::Bridge.new(client)
  end

  def client
    case repository_url
    when /github.com/
      VersionControl::Api::Github.new(repository_access_token)
    else
      #raise 'Unsupported repository'
      nil
    end
  end
end
