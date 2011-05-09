# encoding: UTF-8
class WordRelation < ActiveRecord::Base
  has_one :word_class
end
