require 'rails_helper'

RSpec.describe "/services", type: :request do
  let(:valid_attributes) { attributes_for(:service) }
  let(:invalid_attributes) { attributes_for(:service, name: "") }
  it_behaves_like :controller, Service
end
