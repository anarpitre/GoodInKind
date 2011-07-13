# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110713094117) do

  create_table "non_profit_categories", :force => true do |t|
    t.integer  "non_profit_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "non_profits", :force => true do |t|
    t.string   "name"
    t.string   "EIN"
    t.text     "description"
    t.integer  "gateway_id"
    t.string   "document1_file_name"
    t.string   "document2_file_name"
    t.string   "photo_file_name"
    t.string   "document1_content_type"
    t.string   "document2_content_type"
    t.string   "photo_content_type"
    t.integer  "document1_file_size"
    t.integer  "document2_file_size"
    t.integer  "photo_file_size"
    t.boolean  "is_verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_social_networks", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "social_network_id"
    t.string   "user_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "gender"
    t.string   "website"
    t.text     "about_me"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.boolean  "is_verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_networks", :force => true do |t|
    t.string   "name"
    t.string   "site_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
