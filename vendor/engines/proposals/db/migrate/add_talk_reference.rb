class AddTalkReference < ActiveRecord::Migration

  def self.up
    add_column :proposals, :talk_id, :integer
  end

  def self.down
    remove_column :proposals, :talk_id
  end
end
