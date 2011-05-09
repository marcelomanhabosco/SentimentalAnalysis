class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.integer :entity_id
      t.string :human_score
      t.text :opinion_text

      t.timestamps
    end
  end

  def self.down
    drop_table :opinions
  end
end
