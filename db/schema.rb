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

ActiveRecord::Schema.define(:version => 20110727080827) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "category_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "service_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.boolean  "is_album_cover",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "non_profit_categories", :force => true do |t|
    t.integer  "non_profit_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "non_profits", :force => true do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "EIN"
    t.string   "uuid"
    t.string   "email"
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.boolean  "is_temp_pwd",        :default => true
    t.boolean  "is_verified",        :default => false
    t.boolean  "is_active",          :default => true
    t.string   "permalinks"
    t.string   "phone_number"
    t.text     "description"
    t.integer  "gateway_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "non_profits", ["username"], :name => "index_non_profits_on_username"

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
    t.integer  "age",                 :default => 0
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

  create_table "service_categories", :force => true do |t|
    t.integer  "service_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "amount"
    t.integer  "booking_capacity"
    t.integer  "booked_seats"
    t.boolean  "is_scheduled"
    t.integer  "offerer_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "non_profit_id"
    t.integer  "group_number"
    t.float    "non_profit_percentage"
    t.boolean  "is_virtual"
    t.boolean  "is_public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_networks", :force => true do |t|
    t.string   "name"
    t.string   "site_url"
    t.string   "token"
    t.string   "key"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_service_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.boolean  "is_admin",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
