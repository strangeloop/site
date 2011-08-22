class ChangeServicesAssociationToAttendeeCred < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.remove :user_id
      t.references :attendee_cred
    end
  end

  def self.down
    change_table :services do |t|
      t.references :user
      t.remove :attendee_cred
    end
  end
end
