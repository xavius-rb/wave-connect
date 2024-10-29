class Service < ApplicationRecord
  validates :name, presence: true

  before_create do
    self.uuid = SecureRandom.uuid
  end

  has_many :environments, class_name: 'StageEnvironment', dependent: :destroy

  def repository
    @version_control_repository ||= VersionControl::Repository.new(self)
  end
end
