# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130701231157) do

  create_table "shiller_data_months", :force => true do |t|
    t.string   "year_month"
    t.float    "sp_index"
    t.float    "dividends"
    t.float    "earnings"
    t.float    "cpi"
    t.float    "long_interest_rate"
    t.date     "record_date"
    t.float    "real_sp_index"
    t.float    "real_dividends"
    t.float    "real_earnings"
    t.float    "cape"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.float    "real_sp_index_return"
    t.float    "dividend_return"
    t.float    "real_total_return"
  end

end
