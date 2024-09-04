class AddRepositoryAccessTokenToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :repository_access_token, :string
  end
end
