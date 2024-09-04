require 'rails_helper'

RSpec.describe "/services", type: :request do
  # FIXME: replace with vcr cassettes
  before do
    allow_any_instance_of(Service).to receive(:fetch_commits).and_return([])
    allow_any_instance_of(Service).to receive(:fetch_pull_requests).and_return([])
    allow_any_instance_of(Service).to receive(:fetch_repository_content).and_return([])
    allow_any_instance_of(Service).to receive(:fetch_repository_branches).and_return([])
  end

  it_behaves_like :controller, Service do
    let(:valid_attributes) { attributes_for(:service) }
    let(:invalid_attributes) { attributes_for(:service, name: "") }
  end
end
