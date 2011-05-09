class CreateSynsetWords < ActiveRecord::Migration
  def self.up
    create_table :synset_words, :id => false do |t|
      t.integer :synset_id
      t.string :word

      t.timestamps
    end
  end

  def self.down
    drop_table :synset_words
  end
end
