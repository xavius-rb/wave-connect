require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'callbacks' do
    describe 'before_create' do
      describe '#generate_uuid' do
        let(:service) { build(:service) }

        it 'generates a uuid' do
          expect { service.save }.to change { service.uuid }.from(nil).to(a_string_matching(/\A\h{8}-\h{4}-\h{4}-\h{4}-\h{12}\z/))
        end
      end
    end
  end

  describe '#parse_repository_url' do
    subject { service.parse_repository_url }
    let(:service) { build(:service, repository_url: "https://github.com/xavius-rb/wave-connect") }

    it { is_expected.to eq(["xavius-rb", "wave-connect", ""]) }
  end
end
