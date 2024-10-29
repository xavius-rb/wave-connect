require 'rails_helper'

RSpec.describe StageEnvironmentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/stage_environments').to route_to('stage_environments#index')
    end

    it 'routes to #new' do
      expect(get: '/stage_environments/new').to route_to('stage_environments#new')
    end

    it 'routes to #show' do
      expect(get: '/stage_environments/1').to route_to('stage_environments#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/stage_environments/1/edit').to route_to('stage_environments#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/stage_environments').to route_to('stage_environments#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/stage_environments/1').to route_to('stage_environments#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/stage_environments/1').to route_to('stage_environments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/stage_environments/1').to route_to('stage_environments#destroy', id: '1')
    end
  end
end
