require 'rails_helper'

RSpec.describe VersionControl::Repository do
  let(:service) { build(:service, repository_url: url) }
  let(:repository) { described_class.new(service) }
  let(:url) { "https://github.com/xavius-rb/wave-connect"}

  describe '#owner' do
    subject { repository.owner }

    it { is_expected.to eq("xavius-rb") }
  end

  describe '#repo' do
    subject { repository.repo }

    it { is_expected.to eq("wave-connect") }
  end

  describe '#path' do
    subject { repository.path }

    it { is_expected.to eq("") }
  end

end
