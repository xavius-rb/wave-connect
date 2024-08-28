require 'rails_helper'

RSpec.describe VersionControl::ConnectionFactory do
  describe '.github' do
    let(:url) { 'https://api.github.com' }
    let(:access_token) { 'fake_access_token' }
    let(:connection) { instance_double(Faraday::Connection) }

    before do
      allow(Faraday).to receive(:new).and_yield(connection).and_return(connection)
      allow(connection).to receive(:request)
      allow(connection).to receive(:response)
      allow(connection).to receive(:adapter)
      allow(connection).to receive(:headers).and_return({})
    end

    it 'creates a Faraday connection with the correct URL' do
      described_class.github(url: url, access_token: access_token)
      expect(Faraday).to have_received(:new).with(url: url)
    end

    it 'sets the authorization header' do
      expect(connection).to receive(:request).with(:authorization, 'Bearer', anything)
      described_class.github(url: url, access_token: access_token)
    end

    it 'sets the correct headers' do
      described_class.github(url: url, access_token: access_token)
      expect(connection.headers['Accept']).to eq('application/vnd.github+json')
      expect(connection.headers['X-GitHub-Api-Version']).to eq('2022-11-28')
    end
  end
end