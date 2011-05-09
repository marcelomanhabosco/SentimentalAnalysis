class CreateSynsets < ActiveRecord::Migration
  def self.up
    create_table :synsets do |t|
      t.integer :word_class_id
      t.integer :synset_ant

      t.timestamps
    end
  end

  def self.down
    drop_table :synsets
  end
end
