class CreateWordRelations < ActiveRecord::Migration
  def self.up
    create_table :word_relations do |t|
      t.integer :word_class_id
      t.string :relation
      t.string :word
      t.string :related_word

      t.timestamps
    end
  end

  def self.down
    drop_table :word_relations
  end
end
