class CreateCleanedOpinions < ActiveRecord::Migration
  def self.up
    create_table :cleaned_opinions do |t|
      t.integer :opinion_id
      t.text :cleaned_opinion_text

      t.timestamps
    end
  end

  def self.down
    drop_table :cleaned_opinions
  end
end
