# encoding: UTF-8
class Entity < ActiveRecord::Base
  has_many :opinions
  
  validates_presence_of :name
end
