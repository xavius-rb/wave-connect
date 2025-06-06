require 'rails_helper'

RSpec.describe VersionControl::Api::Github, :vcr do
  let(:auth_token) { 'test_token' }
  let(:client) { described_class.new(auth_token: auth_token) }
  let(:owner) { 'test-owner' }
  let(:repo) { 'test-repo' }

  describe '#initialize' do
    it 'creates a connection with correct configuration' do
      connection = client.instance_variable_get(:@connection)
      expect(connection).to be_a(Faraday::Connection)
      expect(connection.url_prefix.to_s).to eq(described_class::GITHUB_API_URL + '/')
      expect(connection.headers['Accept']).to eq(described_class::GITHUB_API_ACCEPT)
      expect(connection.headers['X-GitHub-Api-Version']).to eq(described_class::GITHUB_API_VERSION)
    end
  end

  describe '#commits' do
    let(:response_body) do
      [
        {
          sha: '123',
          commit: {
            author: { name: 'John Doe', email: 'john.doe@example.com', date: '2025-04-14T04:46:53Z' },
            message: 'Initial commit'
          }
        }
      ]
    end

    subject(:response) { client.commits(owner: owner, repo: repo, per_page: 2) }

    before do
      stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/commits")
        .with(query: { per_page: 2 })
        .to_return(
          status: 200,
          body: response_body.to_json,
          headers: { 'Content-Type': 'application/json' }
        )
    end

    it 'fetches commits with correct parameters' do
      expect(response.body).to be_an(Array)
      expect(response.body.first).to include('sha', 'commit')
    end
  end

  describe '#pull_requests' do
    let(:response_body) { [ { number: 1, title: 'Test PR' } ] }
    subject(:response) { client.pull_requests(owner: owner, repo: repo, per_page: 2) }

    before do
      stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/pulls")
        .with(query: { per_page: 2 })
        .to_return(
          status: 200,
          body: response_body.to_json,
          headers: { 'Content-Type': 'application/json' }
        )
    end

    it 'fetches pull requests with correct parameters' do
      expect(response.body).to be_an(Array)
      expect(response.body.first).to include('number', 'title')
    end
  end

  describe '#workflow_runs' do
    let(:response_body) { { workflow_runs: [ { id: 1, status: 'completed' } ] } }
    subject(:response) { client.workflow_runs(owner: owner, repo: repo, per_page: 2) }

    before do
      stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/actions/runs")
        .with(query: { per_page: 2 })
        .to_return(
          status: 200,
          body: response_body.to_json,
          headers: { 'Content-Type': 'application/json' }
        )
    end

    it 'fetches workflow runs with correct parameters' do
      expect(response.body).to include('workflow_runs')
    end
  end

  describe '#branches' do
    let(:response_body) { [ { name: 'main', commit: { sha: '123' } } ] }
    subject(:response) { client.branches(owner: owner, repo: repo) }

    before do
      stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/branches")
        .to_return(
          status: 200,
          body: response_body.to_json,
          headers: { 'Content-Type': 'application/json' }
        )
    end

    it 'fetches branches' do
      expect(response.body).to be_an(Array)
      expect(response.body.first).to include('name', 'commit')
    end
  end

  describe '#repository_content' do
    let(:response_body) { [ { name: 'file.rb', type: 'file' } ] }
    let(:path) { 'path/to/content' }
    subject(:response) { client.repository_content(owner: owner, repo: repo, path: path) }

    context 'with path' do
      before do
        stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/contents/#{path}")
          .to_return(
            status: 200,
            body: response_body.to_json,
            headers: { 'Content-Type': 'application/json' }
          )
      end

      it 'fetches repository content with path' do
        expect(response.body).to be_an(Array)
        expect(response.body.first).to include('name', 'type')
      end
    end

    context 'without path' do
      subject(:response) { client.repository_content(owner: owner, repo: repo, path: nil) }

      before do
        stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/contents")
          .to_return(
            status: 200,
            body: response_body.to_json,
            headers: { 'Content-Type': 'application/json' }
          )
      end

      it 'fetches repository content without path' do
        expect(response.body).to be_an(Array)
        expect(response.body.first).to include('name', 'type')
      end
    end
  end

  context 'with error responses' do
    describe 'unauthorized access' do
      before do
        stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/commits")
          .with(query: { per_page: 1 })
          .to_return(
            status: 401,
            body: { message: 'Bad credentials' }.to_json,
            headers: { 'Content-Type': 'application/json' }
          )
      end

      it 'handles unauthorized errors' do
        response = client.commits(owner: owner, repo: repo, per_page: 1)
        expect(response.status).to eq(401)
        expect(response.body).to include('message')
      end
    end

    describe 'not found' do
      before do
        stub_request(:get, "#{described_class::GITHUB_API_URL}/repos/#{owner}/#{repo}/commits")
          .with(query: { per_page: 1 })
          .to_return(
            status: 404,
            body: { message: 'Not Found' }.to_json,
            headers: { 'Content-Type': 'application/json' }
          )
      end

      it 'handles not found errors' do
        response = client.commits(owner: owner, repo: repo, per_page: 1)
        expect(response.status).to eq(404)
        expect(response.body).to include('message')
      end
    end
  end
end
