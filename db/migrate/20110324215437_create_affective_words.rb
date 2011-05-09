class CreateAffectiveWords < ActiveRecord::Migration
  def self.up
    create_table :affective_words do |t|
      t.string :word
      t.string :polarity

      t.timestamps
    end
  end

  def self.down
    drop_table :affective_words
  end
end
