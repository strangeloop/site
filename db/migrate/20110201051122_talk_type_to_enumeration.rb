class TalkTypeToEnumeration < ActiveRecord::Migration
  def self.up
    remove_column :talks, :talk_type_id
    drop_table :talk_types
    add_column :talks, :talk_type, :string
  end

  def self.down
    remove_column :talks, :talk_type
    create_table "talk_types" do |t|
      t.string   "name"
      t.string   "description"
    end

    add_column :talks, :references, :talk_type_id
  end
end
