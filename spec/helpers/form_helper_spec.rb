require 'rails_helper'

RSpec.describe FormHelper, type: :helper do
  let(:resource) { Service.new }
  let(:sanitizer) { Rails::Html::FullSanitizer.new }

  def sanitize_html(html)
    sanitizer.sanitize(html.to_s)
  end

  describe '#render_form_errors' do
    context 'when resource has no errors' do
      it 'returns nil' do
        expect(helper.render_form_errors(resource)).to be_nil
      end
    end

    context 'when resource has one error' do
      before do
        resource.errors.add(:name, "can't be blank")
      end

      it 'renders error message' do
        result = sanitize_html(helper.render_form_errors(resource))
        expect(result).to include('1 error prohibited this service from being saved')
        expect(result).to include("Name can't be blank")
      end
    end

    context 'when resource has multiple errors' do
      before do
        resource.errors.add(:name, "can't be blank")
        resource.errors.add(:repository_url, 'is invalid')
      end

      it 'renders multiple error messages' do
        result = sanitize_html(helper.render_form_errors(resource))
        expect(result).to include('2 errors prohibited this service from being saved')
        expect(result).to include("Name can't be blank")
        expect(result).to include('Repository url is invalid')
      end
    end
  end
end
