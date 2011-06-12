class AddFieldsToPolarityOpinionWord < ActiveRecord::Migration
  def self.up
    add_column :polarity_opinion_words, :opinion_sentence_id, :integer
    add_column :polarity_opinion_words, :position, :integer
    remove_column :polarity_opinion_words, :opinion_id
  end

  def self.down
    remove_column :polarity_opinion_words, :opinion_sentence_id
    remove_column :polarity_opinion_words, :position
    add_column :polarity_opinion_words, :opinion_id, :integer
  end
end