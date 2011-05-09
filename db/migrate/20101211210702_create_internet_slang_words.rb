class CreateInternetSlangWords < ActiveRecord::Migration
  def self.up
    create_table :internet_slang_words do |t|
      t.string :slang_word
      t.string :correct_word

      t.timestamps
    end
  end

  def self.down
    drop_table :internet_slang_words
  end
end
