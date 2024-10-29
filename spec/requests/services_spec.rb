require 'rails_helper'

RSpec.describe "/services", type: :request do
  let(:repository) { double(VersionControl::Repository) }

  before do
    allow_any_instance_of(Service).to receive(:repository).and_return(repository)

    allow(repository).to receive(:fetch_commits).and_return([])
    allow(repository).to receive(:fetch_pull_requests).and_return([])
    allow(repository).to receive(:fetch_content).and_return([])
    allow(repository).to receive(:fetch_branches).and_return([])
  end

  it_behaves_like :controller, Service do
    let(:valid_attributes) { attributes_for(:service) }
    let(:invalid_attributes) { attributes_for(:service, name: "") }
  end
end
