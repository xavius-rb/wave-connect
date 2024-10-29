class StageEnvironmentsController < ApplicationController
  before_action :set_stage_environment, only: %i[show edit update destroy]

  # GET /stage_environments or /stage_environments.json
  def index
    @stage_environments = StageEnvironment.all
  end

  # GET /stage_environments/1 or /stage_environments/1.json
  def show; end

  # GET /stage_environments/new
  def new
    @stage_environment = StageEnvironment.new
  end

  # GET /stage_environments/1/edit
  def edit; end

  # POST /stage_environments or /stage_environments.json
  def create
    @stage_environment = StageEnvironment.new(stage_environment_params)

    respond_to do |format|
      if @stage_environment.save
        format.html do
          redirect_to stage_environment_url(@stage_environment), notice: 'Stage environment was successfully created.'
        end
        format.json { render :show, status: :created, location: @stage_environment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stage_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stage_environments/1 or /stage_environments/1.json
  def update
    respond_to do |format|
      if @stage_environment.update(stage_environment_params)
        format.html do
          redirect_to stage_environment_url(@stage_environment), notice: 'Stage environment was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @stage_environment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stage_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_environments/1 or /stage_environments/1.json
  def destroy
    @stage_environment.destroy!

    respond_to do |format|
      format.html { redirect_to stage_environments_url, notice: 'Stage environment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stage_environment
    @stage_environment = StageEnvironment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stage_environment_params
    params.require(:stage_environment).permit(:name)
          .with_defaults(service_id: service&.id)
  end

  helper_method def service
    @service ||= Service.find(params[:service_id])
  end
end
