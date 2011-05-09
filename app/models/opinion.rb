# encoding: UTF-8
class Opinion < ActiveRecord::Base
  belongs_to :entity
  has_one :cleaned_opinion
  has_one :corrected_opinion
  has_many :polarity_opinion_words
  validates_presence_of :opinion_text
end
