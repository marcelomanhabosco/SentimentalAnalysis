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

ActiveRecord::Schema.define(:version => 20110523030257) do

  create_table "affective_words", :force => true do |t|
    t.string   "word"
    t.float    "pos"
    t.float    "neg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cleaned_opinions", :force => true do |t|
    t.integer  "opinion_id"
    t.text     "cleaned_opinion_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "corrected_opinions", :force => true do |t|
    t.integer  "opinion_id"
    t.text     "corrected_opinion_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internet_slang_words", :force => true do |t|
    t.string   "slang_word"
    t.string   "correct_word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinion_sentences", :force => true do |t|
    t.integer  "initial_position"
    t.integer  "final_position"
    t.integer  "sentence_count"
    t.text     "text"
    t.float    "pos"
    t.float    "neg"
    t.integer  "opinion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinions", :force => true do |t|
    t.integer  "entity_id"
    t.string   "human_score"
    t.string   "polarity"
    t.text     "opinion_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polarity_opinion_words", :force => true do |t|
    t.integer  "opinion_sentence_id"
    t.integer  "position"
    t.float    "pos"
    t.float    "neg"
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stop_words", :force => true do |t|
    t.string   "stop_word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "synset_words", :id => false, :force => true do |t|
    t.integer  "synset_id"
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "synsets", :force => true do |t|
    t.integer  "word_class_id"
    t.integer  "synset_ant"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_classes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_relations", :force => true do |t|
    t.integer  "word_class_id"
    t.string   "relation"
    t.string   "word"
    t.string   "related_word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
