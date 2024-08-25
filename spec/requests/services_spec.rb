require 'rails_helper'

RSpec.describe "/services", type: :request do
  it_behaves_like :controller, Service do
    let(:valid_attributes) { attributes_for(:service) }
    let(:invalid_attributes) { attributes_for(:service, name: "") }
  end
end
