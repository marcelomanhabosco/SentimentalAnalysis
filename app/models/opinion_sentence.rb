class OpinionSentence < ActiveRecord::Base
  has_many :polarity_opinion_words, :dependent => :destroy
end
