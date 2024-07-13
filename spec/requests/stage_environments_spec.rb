require 'rails_helper'

RSpec.describe "/stage_environments", type: :request do
  let!(:service) { create(:service) }
  let(:valid_attributes) { attributes_for(:stage_environment, service_id: service.id) }
  let(:invalid_attributes) { attributes_for(:stage_environment, service_id: nil) }

  xspecify do
    it_behaves_like :controller, StageEnvironment, namespace: [service]
  end
end
