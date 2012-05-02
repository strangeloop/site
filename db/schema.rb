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

ActiveRecord::Schema.define(:version => 20120502012420) do

  create_table "attendee_creds", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendee_creds", ["email"], :name => "index_attendee_creds_on_email", :unique => true
  add_index "attendee_creds", ["reset_password_token"], :name => "index_attendee_creds_on_reset_password_token", :unique => true

  create_table "attendees", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "twitter_id"
    t.string   "blog_url"
    t.string   "reg_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company"
    t.string   "state"
    t.integer  "conf_year"
    t.string   "github_id"
    t.string   "work_for_pie_id"
    t.string   "cached_slug"
    t.string   "company_url"
    t.integer  "attendee_cred_id"
  end

  add_index "attendees", ["cached_slug"], :name => "index_attendees_on_cached_slug", :unique => true
  add_index "attendees", ["email"], :name => "index_attendees_on_email", :unique => true
  add_index "attendees", ["first_name"], :name => "index_attendees_on_first_name"
  add_index "attendees", ["last_name"], :name => "index_attendees_on_last_name"
  add_index "attendees", ["reg_id"], :name => "index_attendees_on_reg_id"
  add_index "attendees", ["twitter_id"], :name => "index_attendees_on_twitter_id", :unique => true

  create_table "attendees_conference_sessions", :id => false, :force => true do |t|
    t.integer "attendee_id",           :null => false
    t.integer "conference_session_id", :null => false
  end

  add_index "attendees_conference_sessions", ["attendee_id", "conference_session_id"], :name => "attendees_to_conference_sessions", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conference_sessions", :force => true do |t|
    t.integer  "talk_id"
    t.string   "format"
    t.integer  "slides_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_slug"
    t.integer  "conf_year"
    t.integer  "session_time_id"
    t.integer  "room_id"
  end

  add_index "conference_sessions", ["cached_slug"], :name => "index_conference_sessions_on_cached_slug", :unique => true
  add_index "conference_sessions", ["id"], :name => "index_conference_sessions_on_id"
  add_index "conference_sessions", ["room_id"], :name => "index_conference_sessions_on_room_id"
  add_index "conference_sessions", ["session_time_id"], :name => "index_conference_sessions_on_session_time_id"
  add_index "conference_sessions", ["slides_id"], :name => "index_conference_sessions_on_slides_id"
  add_index "conference_sessions", ["talk_id"], :name => "index_conference_sessions_on_talk_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datastore_images", :force => true do |t|
    t.string   "uid"
    t.binary   "image",      :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datastore_images", ["uid"], :name => "index_datastore_images_on_uid"

  create_table "images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_uid"
    t.string   "image_ext"
  end

  create_table "news_item_translations", :force => true do |t|
    t.integer  "news_item_id"
    t.string   "locale"
    t.string   "external_url"
    t.text     "body"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_item_translations", ["locale"], :name => "index_news_item_translations_on_locale"
  add_index "news_item_translations", ["news_item_id"], :name => "index_news_item_translations_on_news_item_id"

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "publish_date"
    t.integer  "image_id"
    t.string   "external_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_items", ["id"], :name => "index_news_items_on_id"
  add_index "news_items", ["image_id"], :name => "index_news_items_on_image_id"

  create_table "page_part_translations", :force => true do |t|
    t.integer  "page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_part_translations", ["locale"], :name => "index_page_part_translations_on_locale"
  add_index "page_part_translations", ["page_part_id"], :name => "index_page_part_translations_on_page_part_id"

  create_table "page_parts", :force => true do |t|
    t.integer  "page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_parts", ["id"], :name => "index_page_parts_on_id"
  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.string   "custom_title"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_translations", ["locale"], :name => "index_page_translations_on_locale"
  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.string   "custom_title_type",   :default => "none"
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  add_index "pages", ["depth"], :name => "index_pages_on_depth"
  add_index "pages", ["id"], :name => "index_pages_on_id"
  add_index "pages", ["lft"], :name => "index_pages_on_lft"
  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"
  add_index "pages", ["rgt"], :name => "index_pages_on_rgt"

  create_table "proposals", :force => true do |t|
    t.string   "status"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "talk_id"
    t.string   "format"
  end

  add_index "proposals", ["id"], :name => "index_proposals_on_id"
  add_index "proposals", ["talk_id"], :name => "index_proposals_on_talk_id"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "refinery_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable",             :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scoping"
    t.boolean  "restricted",              :default => false
    t.string   "callback_proc_as_string"
    t.string   "form_value_type"
  end

  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

  create_table "resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_uid"
    t.string   "file_ext"
  end

  create_table "roles", :force => true do |t|
    t.string "title"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "roles_users", ["role_id", "user_id"], :name => "index_roles_users_on_role_id_and_user_id"
  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.integer  "conf_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "rooms", ["name"], :name => "index_rooms_on_name"

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

  create_table "session_times", :force => true do |t|
    t.datetime "start_time"
    t.integer  "duration_hours"
    t.integer  "duration_minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "session_times", ["start_time"], :name => "index_session_times_on_start_time"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
    t.string   "locale"
  end

  add_index "slugs", ["locale"], :name => "index_slugs_on_locale"
  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_sluggable_type_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "speakers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "country"
    t.integer  "conf_year"
    t.integer  "image_id"
    t.string   "city"
    t.string   "twitter_id"
    t.string   "company"
    t.string   "company_url"
  end

  add_index "speakers", ["image_id"], :name => "index_speakers_on_image_id"

  create_table "speakers_talks", :id => false, :force => true do |t|
    t.integer "speaker_id"
    t.integer "talk_id"
  end

  add_index "speakers_talks", ["speaker_id", "talk_id"], :name => "index_speakers_talks_on_speaker_id_and_talk_id", :unique => true

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.integer  "image_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsors", ["image_id"], :name => "index_sponsors_on_image_id"

  create_table "sponsorship_levels", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorships", :force => true do |t|
    t.integer  "sponsor_id"
    t.integer  "contact_id"
    t.integer  "sponsorship_level_id"
    t.boolean  "visible"
    t.integer  "year"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["contact_id"], :name => "index_sponsorships_on_contact_id"
  add_index "sponsorships", ["id"], :name => "index_sponsorships_on_id"
  add_index "sponsorships", ["sponsor_id"], :name => "index_sponsorships_on_sponsor_id"
  add_index "sponsorships", ["sponsorship_level_id"], :name => "index_sponsorships_on_sponsorship_level_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "talks", :force => true do |t|
    t.string   "title"
    t.text     "abstract"
    t.text     "prereqs"
    t.text     "comments"
    t.text     "av_requirement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_approval"
    t.string   "talk_type"
    t.string   "duration"
    t.integer  "track_id"
  end

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "conf_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "user_plugins", ["name"], :name => "index_user_plugins_on_title"
  add_index "user_plugins", ["user_id", "name"], :name => "index_unique_user_plugins", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",             :null => false
    t.string   "email",                :null => false
    t.string   "encrypted_password",   :null => false
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.string   "remember_token"
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
  end

  add_index "users", ["id"], :name => "index_users_on_id"

end
