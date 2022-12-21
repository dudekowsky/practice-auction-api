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

ActiveRecord::Schema[7.0].define(version: 20_221_221_213_208) do
  create_table 'bids', force: :cascade do |t|
    t.integer 'offer_id', null: false
    t.string 'password_digest'
    t.integer 'price_in_cents'
    t.string 'buyer_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['offer_id'], name: 'index_bids_on_offer_id'
  end

  create_table 'offers', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.string 'password_digest'
    t.integer 'price_in_cents', default: 0
    t.boolean 'open', default: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'bids', 'offers'
end
