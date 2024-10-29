require 'rails_helper'

RSpec.describe VersionControl::Bridge do
  let(:mocked_client) { double(VersionControl::Api::Github) }
  subject { described_class.new(mocked_client) }

  let(:successful_response) { double(success?: true, body: { data: 'success' }) }
  let(:failed_response) { double(success?: false, status: 401, reason_phrase: 'Unauthorized') }

  describe '#initialize' do
    subject(:bridge) { described_class.new(mocked_client) }

    it 'assigns the api attribute' do
      expect(bridge.api).to eq(mocked_client)
    end
  end

  describe '#repositories' do
    it 'calls client.repositories with the provided org' do
      org = 'example_org'
      expect(mocked_client).to receive(:repositories).with(org: org).and_return(successful_response)
      subject.repositories(org: org)
    end
  end

  describe '#commits' do
    let(:owner) { 'example_owner' }
    let(:repo) { 'example_repo' }
    subject(:bridge) { described_class.new(mocked_client) }

    it 'calls client.commits with the provided owner and repo' do
      expect(mocked_client).to receive(:commits).with(owner: owner, repo: repo, per_page: 2).and_return(successful_response)
      subject.commits(owner: owner, repo: repo, per_page: 2)
    end

    it 'logs error and returns empty hash on failed response' do
      expect(mocked_client).to receive(:commits).and_return(failed_response)
      expect(Rails.logger).to receive(:error).with("Failed to fetch data from version control API: 401 - Unauthorized")
      expect(bridge.commits(owner: owner, repo: repo, per_page: 2)).to eq({})
    end
  end

  describe '#repository_content' do
    it 'calls client.repository_content with the provided owner, repo, and path' do
      owner = 'example_owner'
      repo = 'example_repo'
      path = 'example_path'
      expect(mocked_client).to receive(:repository_content).with(owner: owner, repo: repo, path: path).and_return(successful_response)
      subject.repository_content(owner: owner, repo: repo, path: path)
    end
  end

  describe '#pull_requests' do
    it 'calls client.pull_requests with the provided owner and repo' do
      owner = 'example_owner'
      repo = 'example_repo'
      expect(mocked_client).to receive(:pull_requests).with(owner: owner, repo: repo, per_page: 2).and_return(successful_response)
      subject.pull_requests(owner: owner, repo: repo, per_page: 2)
    end
  end

  describe '#branches' do
    it 'calls client.branches with the provided owner and repo' do
      owner = 'example_owner'
      repo = 'example_repo'
      expect(mocked_client).to receive(:branches).with(owner: owner, repo: repo).and_return(successful_response)
      subject.branches(owner: owner, repo: repo)
    end
  end
end
