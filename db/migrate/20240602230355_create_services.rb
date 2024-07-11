class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name
      t.string :repository_url
      t.string :uuid

      t.timestamps
    end
  end
end
