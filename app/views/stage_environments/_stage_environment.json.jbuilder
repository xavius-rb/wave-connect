json.extract! stage_environment, :id, :service_id, :name, :created_at, :updated_at
json.url environment_url(stage_environment, format: :json)
