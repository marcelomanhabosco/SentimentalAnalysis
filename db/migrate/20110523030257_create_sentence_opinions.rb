class CreateSentenceOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinion_sentences do |t|
      t.integer :initial_position
      t.integer :final_position
      t.integer :sentence_count
      t.string :text
      t.string :polarity
      t.integer :opinion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :opinion_sentences
  end
end
