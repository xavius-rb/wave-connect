# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 20_241_018_230_845) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'services', force: :cascade do |t|
    t.string 'name'
    t.string 'repository_url'
    t.string 'uuid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'repository_access_token'
  end

  create_table 'stage_environments', force: :cascade do |t|
    t.bigint 'service_id', null: false
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['service_id'], name: 'index_stage_environments_on_service_id'
  end

  add_foreign_key 'stage_environments', 'services'
end
