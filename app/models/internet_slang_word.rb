# encoding: UTF-8
class InternetSlangWord < ActiveRecord::Base
  validates_presence_of :slang_word, :correct_word
  validates_uniqueness_of :slang_word
end
