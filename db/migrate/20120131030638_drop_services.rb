class DropServices < ActiveRecord::Migration
  def self.up
    drop_table :services
  end

  def self.down
    create_table :services do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :uname
      t.string :uemail
      t.timestamps
    end
  end
end
