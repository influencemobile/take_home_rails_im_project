# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_210_125_203_424) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'offers', force: :cascade do |t|
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'offers_targets', force: :cascade do |t|
    t.integer 'age'
    t.integer 'offer_id'
    t.string 'gender'
  end

  create_table 'players', force: :cascade do |t|
    t.string 'username'
    t.string 'first_name'
    t.string 'gender'
    t.date 'age'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
