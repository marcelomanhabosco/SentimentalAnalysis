# encoding: UTF-8
class Synset < ActiveRecord::Base
  has_many :synset_words
  has_one :word_class
end
