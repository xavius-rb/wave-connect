class StageEnvironmentsController < ApplicationController
  include Resourceful

  private

  # Only allow a list of trusted parameters through.
  def resource_params
    params.require(:stage_environment).permit(:name)
          .with_defaults(service_id: service&.id)
  end

  helper_method def service
    @service ||= Service.find(params[:service_id])
  end
end
