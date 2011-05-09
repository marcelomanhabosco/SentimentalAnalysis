class CreateStopWords < ActiveRecord::Migration
  def self.up
    create_table :stop_words do |t|
      t.string :stop_word

      t.timestamps
    end
  end

  def self.down
    drop_table :stop_words
  end
end
