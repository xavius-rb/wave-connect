module Resourceful
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i[show edit update destroy]
    respond_to :html, :json
  end

  def index
    instance_variable_set("@#{resource_name_plural}", resource_class.all)
    respond_with(instance_variable_get("@#{resource_name_plural}"))
  end

  def show
    respond_with(resource_instance)
  end

  def new
    instance_variable_set("@#{resource_name}", resource_class.new)
    respond_with(resource_instance)
  end

  def edit
    respond_with(resource_instance)
  end

  def create
    instance_variable_set("@#{resource_name}", resource_class.new(resource_params))
    flash[:notice] = "#{resource_class_name} was successfully created." if resource_instance.save
    respond_with(resource_instance)
  end

  def update
    if resource_instance.update(resource_params)
      flash[:notice] = "#{resource_class_name} was successfully updated."
      respond_with(resource_instance) do |format|
        format.json { render :show, status: :ok, location: resource_instance }
      end
    else
      respond_with(resource_instance)
    end
  end

  def destroy
    resource_instance.destroy!
    flash[:notice] = "#{resource_class_name} was successfully destroyed."
    respond_with(resource_instance, location: send("#{resource_name_plural}_url"))
  end

  private

  def set_resource
    instance_variable_set("@#{resource_name}", resource_class.find(params[:id]))
  end

  def resource_instance
    instance_variable_get("@#{resource_name}")
  end

  def resource_class
    self.class.name.chomp("Controller").singularize.constantize
  end

  def resource_name
    resource_class.name.underscore
  end

  def resource_name_plural
    resource_name.pluralize
  end

  def resource_class_name
    resource_class.model_name.human
  end

  # This method should be overridden in the controller to specify strong parameters
  def resource_params
    raise NotImplementedError, "You must define `resource_params` in your controller."
  end
end
