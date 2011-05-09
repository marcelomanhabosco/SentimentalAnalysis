# encoding: UTF-8
class WordClass < ActiveRecord::Base
  belongs_to :synset
  belongs_to :word_relation
end
