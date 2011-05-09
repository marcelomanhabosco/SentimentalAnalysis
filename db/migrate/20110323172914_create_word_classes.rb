class CreateWordClasses < ActiveRecord::Migration
  def self.up
    create_table :word_classes do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :word_classes
  end
end
