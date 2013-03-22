class AddRememberCreatedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :refinery_users, :remember_created_at, :datetime
  end

  def self.down
    remove_column :refinery_users, :remember_created_at
  end
end
