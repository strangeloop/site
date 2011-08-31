class ChangeFromUserToAttendeeCred < ActiveRecord::Migration
  def self.up
    change_table :attendees do |t|
      t.remove_references :user
      t.references :attendee_cred
    end
  end

  def self.down
    change_table :attendees do |t|
      t.references :user
      t.remove_references :attendee_cred
    end
  end
end
