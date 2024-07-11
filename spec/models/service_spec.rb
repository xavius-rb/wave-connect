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
end
