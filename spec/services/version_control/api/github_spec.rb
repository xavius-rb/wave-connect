require 'rails_helper'

RSpec.describe VersionControl::Api::Github do
  let(:service) { described_class.new(access_token: access_token) }
  let(:access_token) { 'access_token' }

  describe '#repositories' do
    subject(:repositories) { service.repositories(org: org_name) }

    let(:org_name) { 'example' }
    let(:repos_response) { [{ 'name' => 'repo1' }, { 'name' => 'repo2' }] }

    it 'fetches repositories from Github API' do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("/orgs/#{org_name}/repos").and_return(double('Faraday::Response', body: repos_response))

      expect(repositories).to eq(repos_response)
    end
  end

  describe '#commits' do
    subject(:commits) { service.commits(owner: owner, repo: repo, per_page: per_page) }

    let(:owner) { 'example' }
    let(:repo) { 'repo' }
    let(:per_page) { 10 }
    let(:commits_response) { [{ 'sha' => '123' }, { 'sha' => '456' }] }

    it 'fetches commits from Github API' do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("/repos/#{owner}/#{repo}/commits?per_page=#{per_page}").and_return(double('Faraday::Response', body: commits_response))

      expect(commits).to eq(commits_response)
    end
  end

  describe '#repository_content' do
    subject(:repository_content) { service.repository_content(owner: owner, repo: repo, path: path) }

    let(:owner) { 'example' }
    let(:repo) { 'repo' }
    let(:path) { 'path/to/file' }
    let(:content_response) { { 'content' => 'content' } }

    it 'fetches repository content from Github API' do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("/repos/#{owner}/#{repo}/contents/#{path}").and_return(double('Faraday::Response', body: content_response))

      expect(repository_content).to eq(content_response)
    end
  end

  describe '#pull_requests' do
    subject(:pull_requests) { service.pull_requests(owner: owner, repo: repo, per_page: per_page) }

    let(:owner) { 'example' }
    let(:repo) { 'repo' }
    let(:per_page) { 10 }
    let(:pull_requests_response) { [{ 'number' => 1 }, { 'number' => 2 }] }

    it 'fetches pull requests from Github API' do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("/repos/#{owner}/#{repo}/pulls?per_page=#{per_page}").and_return(double('Faraday::Response', body: pull_requests_response))

      expect(pull_requests).to eq(pull_requests_response)
    end
  end

end
