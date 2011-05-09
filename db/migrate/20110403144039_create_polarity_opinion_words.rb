class CreatePolarityOpinionWords < ActiveRecord::Migration
  def self.up
    create_table :polarity_opinion_words do |t|
      t.integer :opinion_id
      t.string :polarity
      t.string :word

      t.timestamps
    end
  end

  def self.down
    drop_table :polarity_opinion_words
  end
end
