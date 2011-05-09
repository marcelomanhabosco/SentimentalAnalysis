class CreateCorrectedOpinions < ActiveRecord::Migration
  def self.up
    create_table :corrected_opinions do |t|
      t.integer :opinion_id
      t.text :corrected_opinion_text

      t.timestamps
    end
  end

  def self.down
    drop_table :corrected_opinions
  end
end
