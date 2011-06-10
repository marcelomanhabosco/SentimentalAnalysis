# encoding: UTF-8
class Opinion < ActiveRecord::Base
  belongs_to :entity
  has_one :cleaned_opinion, :dependent => :destroy
  has_one :corrected_opinion, :dependent => :destroy
  has_many :opinion_sentences, :dependent => :destroy
  validates_presence_of :opinion_text
end
