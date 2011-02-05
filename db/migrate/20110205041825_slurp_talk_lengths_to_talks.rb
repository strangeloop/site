class SlurpTalkLengthsToTalks < ActiveRecord::Migration
  def self.up
    add_column :talks, :talk_length, :string
    remove_column :talks, :talk_length_id
    drop_table :talk_lengths
  end

  def self.down
    remove_column :talks, :talk_length
    create_table "talk_lengths", :force => true do |t|
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_column :talks, :references, :talk_lengths
  end
end
