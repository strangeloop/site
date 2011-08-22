class DeviseCreateAttendeeCreds < ActiveRecord::Migration
  def self.up
    create_table(:attendee_creds) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :attendee_creds, :email,                :unique => true
    add_index :attendee_creds, :reset_password_token, :unique => true
    # add_index :attendee_creds, :confirmation_token,   :unique => true
    # add_index :attendee_creds, :unlock_token,         :unique => true
    # add_index :attendee_creds, :authentication_token, :unique => true
  end

  def self.down
    drop_table :attendee_creds
  end
end
