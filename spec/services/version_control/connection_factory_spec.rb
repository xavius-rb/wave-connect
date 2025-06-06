require 'rails_helper'

RSpec.describe VersionControl::ConnectionFactory do
  describe '.build' do
    let(:url) { 'https://api.example.com/' }
    let(:auth_token) { 'test_token' }
    let(:headers) { { 'Accept' => 'application/json' } }

    subject(:connection) { described_class.build(url: url, auth_token: auth_token, headers: headers) }

    it 'creates a Faraday connection' do
      expect(connection).to be_a(Faraday::Connection)
    end

    it 'sets the base URL' do
      expect(connection.url_prefix.to_s).to eq(url)
    end

    it 'configures JSON response parsing' do
      expect(connection.builder.handlers).to include(Faraday::Response::Json)
    end

    it 'configures URL encoding' do
      expect(connection.builder.handlers).to include(Faraday::Request::UrlEncoded)
    end

    it 'sets custom headers' do
      expect(connection.headers['Accept']).to eq('application/json')
    end

    context 'when no custom headers are provided' do
      subject(:connection) { described_class.build(url: url, auth_token: auth_token) }

      it 'creates a valid connection without custom headers' do
        expect(connection).to be_a(Faraday::Connection)
      end
    end
  end
end
