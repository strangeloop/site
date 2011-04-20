class TalkTypeToEnumeration < ActiveRecord::Migration
  def self.up
    add_column :talks, :talk_type, :string
  end

  def self.down
    remove_column :talks, :talk_type
  end
end
