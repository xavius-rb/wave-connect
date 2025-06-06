class Service < ApplicationRecord
  validates :name, presence: true

  encrypts :repository_access_token

  def version_control_api
    VersionControl::Api::Github.new(auth_token: repository_access_token)
  end
end
