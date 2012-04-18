class AddDurationToTalk < ActiveRecord::Migration
  def self.up
    add_column :talks, :duration, :string
  end

  def self.down
    remove_column :talks, :duration
  end
end
