# encoding: UTF-8
class StopWord < ActiveRecord::Base
  validates_presence_of :stop_word
  validates_uniqueness_of :stop_word
end
