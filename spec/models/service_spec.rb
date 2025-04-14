require 'rails_helper'

RSpec.describe Service, type: :model do
  # This should return the minimal set of attributes required to create a valid
  # Service. As you add validations to Service, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:service)
  }

  let(:invalid_attributes) {
    attributes_for(:service, name: nil)
  }

  describe "validations" do
    it "is valid with valid attributes" do
      service = Service.new(valid_attributes)
      expect(service).to be_valid
    end

    it "is not valid without a name" do
      service = Service.new(invalid_attributes)
      expect(service).not_to be_valid
    end
  end
end
