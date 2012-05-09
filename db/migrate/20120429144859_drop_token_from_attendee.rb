class DropTokenFromAttendee < ActiveRecord::Migration
  def self.up
    remove_column :attendees, :acct_activation_token
    remove_column :attendees, :token_created_at
  end

  def self.down
    add_column :attendees, :acct_activation_token, :string
    add_column :attendees, :token_created_at, :string
  end
end
