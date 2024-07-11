class CreateStageEnvironments < ActiveRecord::Migration[7.1]
  def change
    create_table :stage_environments do |t|
      t.references :service, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
