class AddRepositoryAccessTokenToServices < ActiveRecord::Migration[8.0]
  def change
    add_column :services, :repository_access_token, :string
  end
end
