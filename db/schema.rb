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

ActiveRecord::Schema.define(:version => 20110115225814) do

  create_table "contacts", :force => true do |t|
    t.string   "salutation"
    t.string   "title"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "department"
    t.string   "email"
    t.string   "fon"
    t.string   "mobile"
    t.string   "fax"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "shortname"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "street"
    t.integer  "zip"
    t.string   "city"
    t.string   "fon"
    t.string   "fax"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "discount"
    t.float    "budget"
    t.integer  "type"
    t.integer  "closed"
    t.integer  "customer_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "duration"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
