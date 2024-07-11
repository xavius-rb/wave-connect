require 'rails_helper'

RSpec.describe VersionControl::Api::Github do
  let(:service) { described_class.new }

  describe '#repositories' do
    subject(:repositories) { service.repositories(org: org_name) }

    let(:org_name) { 'example' }
    let(:repos_response) { [{ 'name' => 'repo1' }, { 'name' => 'repo2' }] }

    it 'fetches repositories from Github API' do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("/orgs/#{org_name}/repos").and_return(double('Faraday::Response', body: repos_response))

      expect(repositories).to eq(repos_response)
    end
  end
end
