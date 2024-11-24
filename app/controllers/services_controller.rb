class ServicesController < ApplicationController
  include Resourceful

  private
  # Only allow a list of trusted parameters through.
  def resource_params
    params.require(:service).permit(:name, :repository_url, :uuid)
  end

  helper_method def repository
    @repository ||= @service.repository
  end
end
