class CreatePolarityOpinionWords < ActiveRecord::Migration
  def self.up
    create_table :polarity_opinion_words do |t|
      t.integer :opinion_sentence_id
      t.integer :position
      t.float :pos
      t.float :neg
      t.string :word

      t.timestamps
    end
  end

  def self.down
    drop_table :polarity_opinion_words
  end
end
